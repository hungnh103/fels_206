class Admin::UsersController < ApplicationController
  before_action :check_logged, :check_admin
  before_action :load_user, only: [:destroy]

  def index
    @users = User.select(:id, :name, :email, :is_admin).order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete_user_success"
    else
      flash[:danger] = t "delete_user_fail"
    end
    redirect_to admin_users_path
  end
end
