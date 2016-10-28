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
end
