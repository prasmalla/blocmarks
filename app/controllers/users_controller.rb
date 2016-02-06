class UsersController < ApplicationController

  def signup
    render template: "devise/registrations/new"
  end

  def show
    @created_bookmarks = current_user.created_bookmarks
    @liked_bookmarks = current_user.liked_bookmarks
  end
end