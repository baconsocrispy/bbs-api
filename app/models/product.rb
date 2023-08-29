class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many_attached :product_images, dependent: :destroy
end
