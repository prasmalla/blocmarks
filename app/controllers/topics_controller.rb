class TopicsController < ApplicationController
  before_action :set_topic, except: [:index, :new, :create]

  def index
    @topics = Topic.includes(:bookmarks).all
  end

  def show
    @topic = Topic.includes(:bookmarks).find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:title))
    @topic.user = current_user

    if @topic.save
      flash[:notice] = "Topic created!"
      redirect_to @topic
    else
      flash[:error] = "Oops! try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @topic.update_attributes(params.require(:topic).permit(:title))
      flash[:notice] = "Topic updated!"
      redirect_to @topic
    else
      flash[:error] = "Oops! try again."
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "Topic removed!"
      redirect_to topics_path
    else
      flash[:error] = "Oops! try again."
      redirect_to :back
    end
  end

private
  
  def set_topic
    @topic = Topic.find(params[:id])
  end
end
