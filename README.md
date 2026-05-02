# Ruby on Rails Product (Mini EC 学習用)

## アプリ概要
設定より規約という思想を持つrailsにとってチーム開発における迷わないコーディングやコードレビューの効率化、AIとの相性も良いというチーム開発での悩みを一気に解決できるということで、個人学習向けのミニEC風Webアプリを作成。
AI エージェントを活用したバイブコーディングの題材として、`planner` が改善方針を整理し、`generator` が画面や導線を実装し、`evaluator` が検証観点を持って確認する形で作成・改善しています。  
現在は以下を実装しています。
- メールアドレス/パスワードでのログイン・ログアウト
- 公開中商品の一覧表示
- 商品詳細表示
- 未ログイン時の商品ページアクセス制御

## 公開方針
このアプリは本格運用よりも、ポートフォリオ用途で URL 共有できることを重視しています。  
Render の Free Web Service での公開を想定しており、`render.yaml` と `bin/render-start` を用意しています。  
無料プランの制約上、SQLite は永続化せず、起動ごとに `db:prepare` と `db:seed` を実行してデモデータを再投入する構成です。

## セットアップ手順
前提: Ruby / Bundler / SQLite3 が利用可能であること

```bash
bundle install
bin/rails db:setup
```

## ローカル Ruby での起動
```bash
bin/rails s
```

ブラウザで以下にアクセスします。
- `http://127.0.0.1:3000/login`

補足:
- ローカル起動は、`.ruby-version` に合う Ruby と `Gemfile.lock` に合う Bundler が入っている前提です
- 手元の Ruby / Bundler が合わない場合は `bin/rails s` が失敗するため、その場合は下の Docker 起動を使ってください

## Docker での起動
Docker Compose を使う場合は、プロジェクトルートで以下を実行します。

```bash
docker compose up --build
```

初回起動時は `Dockerfile` のビルドに時間がかかります。起動後は以下にアクセスします。
- `http://127.0.0.1:3000/`
- `http://127.0.0.1:3000/login`

補足:
- `compose.yml` では `Dockerfile` を使ってアプリをビルドします
- ローカル Docker では `FORCE_SSL=false` を設定し、HTTP で開けるようにしています
- ブラウザによっては `localhost` を自動で `https` に寄せることがあるため、ローカル確認では `127.0.0.1` の利用を推奨します
- コンテナ起動時に `bin/docker-entrypoint` が `db:prepare` と `db:seed` を実行します
- SQLite はコンテナ内に作成されるため、`docker compose down --volumes` やコンテナ再作成時にはデータが消えることがあります

## Render での公開
このリポジトリは Render 向けの設定済みです。GitHub に push したあと、Render で `New +` から `Blueprint` または `Web Service` を選んでデプロイできます。

主な設定:
- `render.yaml`: Render の無料 Web Service 設定
- `bin/render-start`: 起動時に DB を準備し、seed を投入してから Puma を起動

公開時のポイント:
- `RAILS_MASTER_KEY` は Render 側で環境変数として設定してください
- `SECRET_KEY_BASE` は `render.yaml` の `generateValue` で自動生成されます
- 無料プランではサービスが 15 分アイドルでスリープし、ローカルファイルは再起動時に失われます
- そのため、データ保持ではなくデモ公開向けの構成です

## デモログイン情報
- Email: `demo@example.com`
- Password: `password123`

## 使用技術
- Ruby on Rails 7 系
- SQLite3
- ERB
- Minitest
- `has_secure_password` (bcrypt)
- 素のCSS（FLOCSS参考の `c-` / `p-` クラス設計）

## 実装した画面
- ログイン画面: `/login`
- 商品一覧画面: `/products`
- 商品詳細画面: `/products/:id`

## 認証方式の概要
- `User` モデルで `has_secure_password` を使用
- ログイン成功時に `session[:user_id]` を保存
- `ApplicationController#current_user` でログイン中ユーザーを取得
- `before_action :require_login` で未ログインアクセスを制御

## テスト
以下でテストを実行します。

```bash
bin/rails test
```

主なテスト対象:
- User モデルのバリデーション
- Product モデルのバリデーション
- ログイン成功/失敗
- 未ログイン時の商品一覧アクセス制御
- ログイン後の商品一覧表示
- 商品詳細表示
