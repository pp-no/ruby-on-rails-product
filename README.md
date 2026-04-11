# Ruby on Rails Product (Mini EC 学習用)

## アプリ概要
個人学習向けのミニEC風Webアプリです。  
AI エージェントを活用したバイブコーディングの題材として、`planner` が改善方針を整理し、`generator` が画面や導線を実装し、`evaluator` が検証観点を持って確認する形で作成・改善しています。  
現在は以下を実装しています。
- メールアドレス/パスワードでのログイン・ログアウト
- 公開中商品の一覧表示
- 商品詳細表示
- 未ログイン時の商品ページアクセス制御

## セットアップ手順
前提: Ruby / Bundler / SQLite3 が利用可能であること

```bash
bundle install
bin/rails db:setup
```

## 起動方法
```bash
bin/rails s
```

ブラウザで以下にアクセスします。
- `http://localhost:3000/login`

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
