class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :follower_id, presence: true
  validates :following_id, presence: true

  FOLLOW_COLOR = "text-blue-500 bg-white hover:bg-blue-300 rounded border w-32 py-1 px-2 text-center".freeze
  UNFOLLOW_COLOR = "text-white bg-blue-400 hover:bg-blue-500 rounded w-32 py-1 px-2 text-center".freeze
end
