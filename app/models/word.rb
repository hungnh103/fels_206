class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :category

  validates :content, presence: true

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, keyword{
    where("content LIKE ? ", "%#{keyword}%")
  }
end
