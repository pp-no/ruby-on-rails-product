require "test_helper"

class ProductsAccessTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Demo User",
      email: "demo@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    @product = Product.create!(
      name: "オーバーサイズ ロゴTシャツ",
      brand_name: "North Street",
      price: 3900,
      description: "ドロップショルダーの定番ロゴT。",
      category: "メンズ",
      size_info: "M/L/XL",
      image_url: "https://example.com/images/products/mens_tshirt_01.jpg",
      published: true
    )
  end

  test "未ログイン時に商品一覧へアクセスすると login へリダイレクト" do
    get products_path

    assert_redirected_to login_path
  end

  test "ログイン後に商品一覧が表示される" do
    post login_path, params: { email: @user.email, password: "password123" }
    get products_path

    assert_response :success
    assert_match @product.name, response.body
    assert_match @product.brand_name, response.body
  end

  test "商品詳細が表示される" do
    post login_path, params: { email: @user.email, password: "password123" }
    get product_path(@product)

    assert_response :success
    assert_match @product.name, response.body
    assert_match @product.brand_name, response.body
    assert_match @product.category, response.body
    assert_match @product.size_info, response.body
  end
end
