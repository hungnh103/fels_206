class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :category

  validates :content, presence: true
end
