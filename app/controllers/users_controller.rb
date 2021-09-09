class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.xlsx {
        render :xlsx => "index", :filename => "all_users.xlsx"
      }
      format.html { render :index }
    end
  end

  def create
  end
end
