class LikesController < ApplicationController
  before_action :set_bookmark

  def create
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like
    
    if like.save
      flash.now[:notice] = "Like added!"
    else
      flash.now[:error] = "Oops! try again."
    end
    
    respond_to do |format|
      format.html {redirect_to [@bookmark.topic, @bookmark]}
      format.js
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    authorize like

    if like.destroy
      flash.now[:notice] = "Like removed!"
    else
      flash.now[:error] = "Oops! try again."
    end

    respond_to do |format|
      format.html {redirect_to [@bookmark.topic, @bookmark]}
      format.js
    end
  end

private

  def set_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end

end
