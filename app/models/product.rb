class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_one_attached :default_image, dependent: :destroy
  has_many_attached :product_images, dependent: :destroy
end
