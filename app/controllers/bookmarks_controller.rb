class BookmarksController < ApplicationController
  before_action :set_bookmark, except: [:new, :create]
  
  def show
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = current_user.bookmarks.build(params.require(:bookmark).permit(:url))
    @bookmark.topic = @topic
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark added!"
      redirect_to @topic
    else
      flash[:error] = "Oops! try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @bookmark.update_attributes(params.require(:bookmark).permit(:url))
      flash[:notice] = "Bookmark updated!"
      redirect_to @topic
    else
      flash[:error] = "Oops! try again."
      render :edit
    end
  end

  def destroy
    if @bookmark.destroy
      flash[:notice] = "Bookmark removed!"
      redirect_to @topic
    else
      flash[:error] = "Oops! try again."
      redirect_to :back
    end
  end

private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @bookmark
  end
end
