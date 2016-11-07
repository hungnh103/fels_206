class Admin::WordsController < ApplicationController
  before_action :check_logged, :check_admin
  before_action :load_word, only: [:destroy]

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @categories = Category.all
    @words = Word.includes(:answers).in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_word
  end

  def destroy
    if @word.results.any?
      flash[:danger] = t ".reject_delete_word"
    else
      if @word.destroy
        flash[:success] = t ".delete_word_success"
      else
        flash[:danger] = t ".delete_word_fail"
      end
    end
    redirect_to admin_words_path
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    if @word.nil?
      flash[:danger] = t ".word_not_found"
      redirect_to admin_words_path
    end
  end
end
