class Admin::WordsController < ApplicationController
  before_action :check_logged, :check_admin
  before_action :load_word, only: [:destroy]
  before_action :load_categories, except: [:destroy]

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @words = Word.order(created_at: :DESC)
      .includes(:answers).in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_word
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t ".create_word_success"
      redirect_to admin_words_url
    else
      render :new
    end
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

  def load_categories
    @categories = Category.all
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
