class Product < ApplicationRecord
  scope :published, -> { where(published: true) }

  validates :name, presence: true
  validates :brand_name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
