require 'faker'

# admin user
user = User.new(
  name: 'admin user',
  email: 'default@user.com',
  password: 'dafault1',
  role: 'admin'
)
user.skip_confirmation!
user.save!

# users
3.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.skip_confirmation!
  user.save! 
end
users = User.all

# topics
6.times do
  Topic.create(user: users.sample, title: Faker::Hipster.sentence(1, false, 1).chop)
end
topics = Topic.all

# bookmarks
9.times do
  Bookmark.create(topic: topics.sample, url: Faker::Internet.url, user: users.sample)
end