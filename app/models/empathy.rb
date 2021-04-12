class Empathy < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  EMPATHY_COLOR = "text-white bg-red-500".freeze
  UNEMPATHY_COLOR = "text-red-500 bg-white".freeze
end
