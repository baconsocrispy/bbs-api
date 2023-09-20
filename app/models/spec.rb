class Spec < ApplicationRecord
  belongs_to :product
  validates :category, presence: true
  validates :text, presence: true
end
