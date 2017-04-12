class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  #before_action :authorize_user, except: [:index, :show] old version
  before_action :authorize_user, except: [:index, :show, :create]


  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end #def create

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def update
    @topic = Topic.find(params[:id])

    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "error saving topic. Please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the topic."
      render :show
    end
  end #def destroy

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
  #defines authorize_user which is used above to redirect non-admin users to topics_path
  def authorize_user
    unless current_user.admin? || current_user.moderator?
      flash[:alert] = "You must be an admin or mod to do that."
      redirect_to topics_path
    end
  end #def authorize_user
end #class TopicsController
