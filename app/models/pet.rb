class Pet < ApplicationRecord
  validates :name, presence: true
  validates :breed, presence: true
  validates :image, presence: true
end
