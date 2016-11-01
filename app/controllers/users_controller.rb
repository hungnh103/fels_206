class UsersController < ApplicationController
  before_action :check_logged, except: [:new, :create]
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.select(:id, :name, :email).order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_user
    @user = User.find_by id: params[:id]
    render_404 if @user.nil?
  end
end
