class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def check_logged
    unless logged_in?
      flash[:danger] = t "not_login"
      redirect_to root_path
    end
  end

  def check_admin
    unless current_user.is_admin?
      flash[:danger] = t "access_denied"
      redirect_to root_path
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to admin_users_path
    end
  end
end
