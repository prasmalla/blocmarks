class User < ActiveRecord::Base
  # Other available devise modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :topics, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def liked(bookmark_id)
    likes.where(bookmark_id: bookmark_id).first
  end
end
