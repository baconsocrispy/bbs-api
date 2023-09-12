class Product < ApplicationRecord
  belongs_to :group
  has_one_attached :default_image, dependent: :destroy
  has_many_attached :product_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
