class Category < ApplicationRecord
  has_many :words, depedent: :destroy
  has_many :lessons, depedent: :destroy

  validates :name, presence: true
end
