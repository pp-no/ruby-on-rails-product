# syntax = docker/dockerfile:1

# `.ruby-version` と `Gemfile` に合わせて Ruby の版を固定する
ARG RUBY_VERSION=3.2.10
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# アプリケーションの作業ディレクトリを `/rails` にする
WORKDIR /rails

# 本番実行を前提にした環境変数を設定する
# `BUNDLE_WITHOUT` で development/test の gem を除外し、
# `RAILS_SERVE_STATIC_FILES` で Rails から静的ファイルを配信できるようにする
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES="1"


# ビルド専用ステージ
# gem のインストールやアセット事前コンパイルだけをここで行い、
# 最終イメージには必要な成果物だけを渡してサイズを抑える
FROM base as build

# ネイティブ拡張付き gem のビルドに必要なパッケージを入れる
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libsqlite3-dev libvips libyaml-dev pkg-config

# `Gemfile.lock` と同じ Bundler を入れて依存解決の差異を防ぐ
RUN gem install bundler -v 2.7.1

# 依存 gem を先にインストールする
# `Gemfile` だけ先にコピーすることで、アプリ本体の変更時も
# gem インストール結果を Docker のキャッシュで再利用しやすくする
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# アプリケーション本体をコピーし、起動スクリプトに実行権限を付ける
COPY . .
RUN chmod +x bin/rails bin/rake bin/setup bin/docker-entrypoint bin/render-start

# Bootsnap のキャッシュを事前生成して起動を速くする
RUN bundle exec bootsnap precompile app/ lib/

# 本番用アセットを事前コンパイルする
# この段階では暗号鍵を要求しないようにダミーの `SECRET_KEY_BASE` を使う
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile


# 実行用の最終ステージ
# ビルドに不要な開発ツールを含めず、本番実行に必要なものだけを残す
FROM base

# 実行時に必要な OS パッケージだけを入れる
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips libyaml-0-2 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# ビルドステージで作った gem とアプリ本体を引き継ぐ
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# セキュリティのため非 root ユーザーで動かす
# 実行時に書き込みが必要なディレクトリだけ所有権を渡す
RUN useradd rails --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp/pids && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# 起動前に DB 準備などを行うエントリポイントを設定する
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# デフォルトでは Rails サーバーを 3000 番ポートで起動する
# `docker run` / `docker compose` 側で別コマンドに上書き可能
EXPOSE 3000
CMD ["./bin/rails", "server"]
