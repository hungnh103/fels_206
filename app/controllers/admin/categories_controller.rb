class Admin::CategoriesController < ApplicationController
  before_action :check_logged
  before_action :check_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_category_success"
      redirect_to admin_categories_path
    else
      render :new
      flash[:danger] = t "add_category_fail"
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_category_success"
      redirect_to admin_categories_path
    else
      flash[:success] = t "update_category_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      if @category.words.any?
        flash[:danger] = t "reject_delete_category"
      else
        flash[:success] = t "delete_category_success"
      end
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "category_not_found"
      redirect_to admin_categories_path
    end
  end
end
