class Summary < ApplicationRecord
  validates :header, presence: true
  validates :copy, presence: true
end
