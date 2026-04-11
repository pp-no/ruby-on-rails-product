require "test_helper"

class SessionsLoginTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Demo User",
      email: "demo@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "ログイン成功で products へ遷移" do
    post login_path, params: { email: @user.email, password: "password123" }

    assert_redirected_to products_path
    follow_redirect!
    assert_response :success
  end

  test "ログイン失敗で new を再表示" do
    post login_path, params: { email: @user.email, password: "wrong-password" }

    assert_response :unprocessable_content
    assert_match "メールアドレスまたはパスワードが正しくありません", response.body
  end
end
