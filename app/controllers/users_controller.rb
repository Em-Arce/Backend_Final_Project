class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
    @users = User.all
    respond_to do |format|
      format.xlsx {
        render :xlsx => "index", :filename => "all_users.xlsx"
      }
      format.html { render :index }
    end
  end

  private

  def is_admin
    unless current_user.admin?
      redirect_to static_pages_welcome_path, notice: "Unauthorized access."
    end
  end
end
