class Feature < ApplicationRecord
  belongs_to :product, inverse_of: :features
  validates :text, presence: true
end
