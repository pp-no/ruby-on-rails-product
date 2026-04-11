class HomeController < ApplicationController
  def index
    published_products = Product.published.order(created_at: :desc)

    @featured_products = published_products.limit(3)
    @published_count = published_products.count
    @category_count = published_products.where.not(category: [nil, ""]).distinct.count(:category)
    @brand_count = published_products.where.not(brand_name: [nil, ""]).distinct.count(:brand_name)
  end
end
