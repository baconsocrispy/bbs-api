class Summary < ApplicationRecord
  validates :header, presence: true
  validates :copy, presence: true

  has_one_attached :banner_image, dependent: :destroy
end
