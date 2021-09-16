class AbstractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  private
  def set_user
      @user = User.find(params[:id])
      @participations = @user.participations.all
  end
end
