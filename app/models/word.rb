class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :category

  validates :content, presence: true
  validate :validate_answer

  QUERY_LEARNED = "content like :search and id in (select word_id
    FROM results INNER JOIN lessons
    ON results.lesson_id = lessons.id AND lessons.user_id = :user_id)"
  QUERY_NOT_LEARNED = "content like :search and id not in (select word_id
    FROM results INNER JOIN lessons
    ON results.lesson_id = lessons.id AND lessons.user_id = :user_id)"

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}
  after_initialize :build_word_answers

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :show_all, -> user_id, keyword{
    where("content LIKE ? ", "%#{keyword}%")
  }

  scope :learned, -> user_id, search{
    where QUERY_LEARNED, user_id: user_id, search: "%#{search}%"
  }

  scope :not_learned, -> user_id, search{
    where QUERY_NOT_LEARNED, user_id: user_id, search: "%#{search}%"
  }

  scope :search, -> keyword, category_id{
    where "content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}"
  }

  scope :filter_category, -> category_id{
    where "category_id = ?", "#{category_id}"
  }

  private
  def build_word_answers
    if self.new_record? && self.answers.size == 0
      Settings.admin.words.default_size_word_answers.times {self.answers.build}
    end
  end

  def validate_answer
    size_correct = self.answers.select{|answer| answer.is_correct}.size
    if size_correct != 1
      errors.add "Warning: ", I18n.t(".number_correct_answer")
    end
  end
end
