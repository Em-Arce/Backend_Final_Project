class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    @user =  User.find(params[:user_id])
    @abstracts = @user.abstracts.all
    @participation = @user.participations.find(params[:id])
  end

  def profile
    @user =  User.find(params[:user_id])
    @abstracts = @user.abstracts.all
    @participation = @user.participations.find(params[:participation_id])
  end

  def edit
    @user =  User.find(params[:user_id])
    @participation = @user.participations.find(params[:id])
  end

  def update
    @user =  User.find(params[:user_id])
    @participation = @user.participations.find(params[:id])
    @participations = @user.participations.all

    #for multiple abstracts hence multiple participations, the changes in
    #one participation is cascaded to all participations
    #@participation.set_kind(params[:user_id], params[:participation][:kind], params[:id])
    @participations.each do |participation|
      participation.update!(kind: params[:participation][:kind])
      @participation.set_fee
    end

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
    city = params[:participation][:city]
    country = params[:participation][:country]
    @user.update!(prefix: prefix, first_name: first_name, last_name: last_name,
      suffix: suffix, email: email, position: position,
      university_institute_company: university_institute_company,
      department: department, contact_number: contact_number, city: city,
      country: country)

    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to user_participation_profile_path(@user, @participation),
          notice: "Your participation details successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      # rescue ActiveRecord::RecordInvalid => e
      #   return e.record
    end
  end

  private
  def participation_params
    params.require(:participation).permit(:kind)
  end

  def render_unprocessable_entity_response(invalid)
    #render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    redirect_to "/500.html" #404/422/500 -server error
  end
end
