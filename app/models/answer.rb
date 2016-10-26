class Answer < ApplicationRecord
  belongs_to :word
  has_many :results

  validates :content, presence: true
  validates :is_correct, presence: true
end
