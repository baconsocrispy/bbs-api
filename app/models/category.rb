class Category < ApplicationRecord
  after_validation :set_slug, only: %i[ create update ]

  has_many :groups, dependent: :destroy
  has_one_attached :banner_image, dependent: :destroy
  has_one_attached :category_image, dependent: :destroy
  has_one_attached :pinned_image, dependent: :destroy


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
