class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = Word.with_correct_answer
      .paginate page: params[:page], per_page: Settings.word.per_page
  end
end
