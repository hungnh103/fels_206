class Answer < ApplicationRecord
  has_many :results

  validates :content, presence: true
  validates :is_correct, presence: true
end
