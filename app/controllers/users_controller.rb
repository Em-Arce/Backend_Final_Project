class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, only: %i[index]
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
    respond_to do |format|
      format.xlsx {
        render :xlsx => "index", :filename => "all_users.xlsx"
      }
      format.html { render :index }
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "#{@user.email} details successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def is_admin
    unless current_user.admin?
      redirect_to static_pages_welcome_path, notice: "Unauthorized access."
    end
  end

  def set_user
      @user = User.find(params[:id])
      @abstracts = @user.abstracts.all
  end

  def user_params
    params.require(:user).permit(:prefix, :prefix,:first_name,:last_name,
          :email, :position, :university_institute_company, :department,
          :contact_number, abstracts_attributes: [:title, :main_author,
          :co_authors, :body]) #participations_attributes: [:fee]
  end
end
