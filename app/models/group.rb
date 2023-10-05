class Group < ApplicationRecord
  after_validation :set_slug, only: %i[ create update ]

  belongs_to :category
  has_many :product_groupings, dependent: :destroy
  has_one_attached :group_image, dependent: :destroy
  has_one_attached :banner_image, dependent: :destroy

  has_many :products, :through => :product_groupings

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
