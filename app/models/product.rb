class Product < ApplicationRecord
  after_validation :set_slug, only: %i[ create update ]
  
  belongs_to :group
  has_one_attached :default_image, dependent: :destroy
  has_many_attached :product_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  # override default to_param method to use slug instead of id
  def to_param
    "#{ slug }"
  end

  private
  def set_slug
    self.slug = name.to_s.parameterize
  end
end
