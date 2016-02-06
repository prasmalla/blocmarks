class LikesController < ApplicationController
  before_action :set_bookmark

  def create
    like = current_user.likes.build(bookmark: @bookmark)
    
    if like.save
      flash[:notice] = "Like added!"
      redirect_to topic_bookmark_path(@bookmark.topic, @bookmark)
    else
      flash[:error] = "Oops! try again."
      render :back
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "Like removed!"
      redirect_to topic_bookmark_path(@bookmark.topic, @bookmark)
    else
      flash[:error] = "Oops! try again."
      render :back
    end
  end

private

  def set_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end

end
