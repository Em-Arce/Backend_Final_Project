class AbstractsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @abstract = @user.abstracts.build
  end

  def create
    @user = current_user
    @abstract = @user.abstracts.create(abstract_params)

    data = []
    params[:abstract][:co_authors].reject(&:empty?).each do |id|
      if id !=nil || id !=""
        data << User.find(id)
        @abstract.update!(co_authors: data)
      end
    end
    #binding.pry
    redirect_to user_path(current_user.id), notice: "Abstract submission completed."

  end

  private

  def abstract_params
    params.require(:abstract).permit(:title, :main_author, :co_authors, :body)
  end
end
