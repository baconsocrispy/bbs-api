class Category < ApplicationRecord
  after_validation :set_slug, only: %i[ create update ]

  has_many :product_categories
  has_many :products, through: :product_categories

  # override default to_param method to use slug instead of id
  def to_param
    "#{ slug }"
  end

  private
  def set_slug
    self.slug = name.to_s.parameterize
  end
end
