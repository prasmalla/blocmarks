class User < ActiveRecord::Base
  # Other available devise modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :topics, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def admin?
    role == 'admin'
  end
end
