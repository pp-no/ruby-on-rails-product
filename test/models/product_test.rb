require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "name, brand_name, price があれば有効" do
    product = Product.new(name: "Tシャツ", brand_name: "Brand", price: 3000)

    assert product.valid?
  end

  test "name がないと無効" do
    product = Product.new(name: nil, brand_name: "Brand", price: 3000)

    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "brand_name がないと無効" do
    product = Product.new(name: "Tシャツ", brand_name: nil, price: 3000)

    assert_not product.valid?
    assert_includes product.errors[:brand_name], "can't be blank"
  end

  test "price がないと無効" do
    product = Product.new(name: "Tシャツ", brand_name: "Brand", price: nil)

    assert_not product.valid?
    assert_includes product.errors[:price], "can't be blank"
  end

  test "price が負数だと無効" do
    product = Product.new(name: "Tシャツ", brand_name: "Brand", price: -100)

    assert_not product.valid?
    assert_includes product.errors[:price], "must be greater than or equal to 0"
  end

  test "price が整数でないと無効" do
    product = Product.new(name: "Tシャツ", brand_name: "Brand", price: 12.5)

    assert_not product.valid?
    assert_includes product.errors[:price], "must be an integer"
  end
end
