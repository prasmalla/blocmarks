class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :history

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true

  def should_generate_new_friendly_id?
    new_record? || title_changed?
  end
end
