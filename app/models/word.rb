class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :category

  validates :content, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  after_initialize :build_word_answers

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, keyword{
    where("content LIKE ? ", "%#{keyword}%")
  }

  scope :with_correct_answer, -> do
    joins("inner join answers on words.id = answers.word_id \n
      and answers.is_correct = 't'")
      .select("words.id, words.content as w_content, \n
        answers.content as a_content")
  end

  private
  def build_word_answers
    if self.new_record? && self.answers.size == 0
      Settings.admin.words.default_size_word_answers.times {self.answers.build}
    end
  end
end
