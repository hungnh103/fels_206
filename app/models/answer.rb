class Answer < ApplicationRecord
  has_many :results

  validates :content, presence: true
end
