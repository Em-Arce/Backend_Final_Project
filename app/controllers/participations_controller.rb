class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user =  User.find(params[:user_id])
    @abstracts = @user.abstracts.all
    @participation = @user.participations.find(params[:id])
  end

  def edit
    @user =  User.find(params[:user_id])
    @participation = @user.participations.find(params[:id])
  end

  def update
    @user =  User.find(params[:user_id])
    #@abstract = @user.abstracts.first
    @participation = @user.participations.find(params[:id])

    #update user details without going to another link
    prefix = params[:participation][:prefix]
    first_name = params[:participation][:first_name]
    last_name = params[:participation][:last_name]
    suffix = params[:participation][:suffix]
    email = params[:participation][:email]
    position = params[:participation][:position]
    university_institute_company = params[:participation][:university_institute_company]
    department = params[:participation][:department]
    contact_number = params[:participation][:contact_number]
    @user.update!(prefix: prefix, first_name: first_name, last_name: last_name,
      suffix: suffix, email: email, position: position,
      university_institute_company: university_institute_company,
      department: department, contact_number: contact_number)

    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to user_participation_path(@user, @participation),
          notice: "Your participation details successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def participation_params
    params.require(:participation).permit(:kind)
  end
end
