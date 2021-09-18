class AbstractsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, only: %i[index destroy]

  def index
    @abstracts = Abstract.all
    respond_to do |format|
      format.xlsx {
        render :xlsx => "index", :filename => "all_abstracts.xlsx"
      }
      format.html { render :index }
    end
  end

  def new
    @user = current_user
    @abstract = @user.abstracts.build
  end

  def create
    @user = current_user
    @abstract = @user.abstracts.create(abstract_params)

    #clean up and do correct format for these fields
    @abstract.format_params_field(:co_authors, params[:abstract][:co_authors], @abstract)
    @abstract.format_params_field(:keywords, params[:abstract][:keywords], @abstract)
    @abstract.format_params_field(:references, params[:abstract][:references], @abstract)

    respond_to do |format|
      if @abstract.save
        AbstractMailer.abstract_submission(@user.id, @abstract).deliver_later
        format.html { redirect_to user_abstract_path(@user, @abstract), notice: "Abstract submission completed." }
        format.json { render :show, status: :created, location: @abstract }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @abstract.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def is_admin
    unless current_user.admin?
      redirect_to static_pages_welcome_path, notice: "Unauthorized access."
    end
  end

  def abstract_params
    params.require(:abstract).permit(:title, :main_author, :co_authors, :corresponding_author_email, :keywords, :body, :references)
  end
end
