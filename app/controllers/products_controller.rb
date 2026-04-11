class ProductsController < ApplicationController
  before_action :require_login

  def index
    @products = Product.published.order(created_at: :desc)
    @categories = @products.where.not(category: [nil, ""]).distinct.order(:category).pluck(:category)
    @brand_count = @products.where.not(brand_name: [nil, ""]).distinct.count(:brand_name)
  end

  def show
    @product = Product.published.find(params[:id])
    @related_products = Product.published
                               .where(category: @product.category)
                               .where.not(id: @product.id)
                               .order(created_at: :desc)
                               .limit(3)
  end
end
