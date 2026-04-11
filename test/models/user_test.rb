require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name, email, password があれば有効" do
    user = User.new(
      name: "Test User",
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert user.valid?
  end

  test "name がないと無効" do
    user = User.new(
      name: nil,
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "email がないと無効" do
    user = User.new(
      name: "Test User",
      email: nil,
      password: "password123",
      password_confirmation: "password123"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "email は一意" do
    User.create!(
      name: "Existing User",
      email: "dup@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    user = User.new(
      name: "Another User",
      email: "dup@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "password は8文字以上" do
    user = User.new(
      name: "Short Password",
      email: "short@example.com",
      password: "short",
      password_confirmation: "short"
    )

    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 8 characters)"
  end
end
