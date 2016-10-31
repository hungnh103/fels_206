class Admin::UsersController < ApplicationController
  before_action :check_logged, :check_admin, only: [:index]

  def index
    @users = User.select(:name, :email, :is_admin).order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.user.per_page
  end
end
