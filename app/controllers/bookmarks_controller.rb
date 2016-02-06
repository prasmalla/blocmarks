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
    @bookmark = @topic.bookmarks.build(bookmark_params.merge(user_id: current_user.id))
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
    respond_to do |format|
      if @bookmark.destroy
        format.html {redirect_to @topic, notice: 'Bookmark removed!'}
        format.js {flash.now[:notice] = 'Bookmark removed!'}
      else
        format.html {redirect_to :back, error: 'Oops! try again.'}
        format.js {flash.now[:error] = 'Oops! try again.'}
      end
    end
  end

private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @bookmark
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id)
  end
end
