class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  # find or create user/topic to add bookmark
  def create
    user = User.find_by(email: params[:sender])
    topic = Topic.find_by(title: params[:subject])
    url = params["body-plain"]

    if user.nil?
      user = User.new(email: params[:sender], password: '12345678')
      user.skip_confirmation!
      user.save!
    end

    topic = Topic.create(title: params[:subject], user: user) if topic.nil?
    
    Bookmark.create(topic: topic, url: url)

    head 200
  end
end
