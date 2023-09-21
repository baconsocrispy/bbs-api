class Product < ApplicationRecord
  after_validation :set_slug, only: %i[ create update ]
  
  belongs_to :group
  has_many :features, dependent: :destroy, inverse_of: :product
  has_many :specs, dependent: :destroy
  has_many :text_blocks, dependent: :destroy

  # images
  has_one_attached :default_image, dependent: :destroy
  has_many_attached :product_images, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :features, allow_destroy: true

  # override default to_param method to use slug instead of id
  def to_param
    "#{ slug }"
  end

  private
  def set_slug
    self.slug = name.to_s.parameterize
  end
end
