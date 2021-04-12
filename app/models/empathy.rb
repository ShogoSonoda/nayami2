class Empathy < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  EMPATHY_COLOR = "inline-block border border-red-500 py-1 px-2 rounded-lg text-white bg-red-500".freeze
  UNEMPATHY_COLOR = "inline-block border border-red-500 py-1 px-2 rounded-lg text-red-500 bg-white".freeze
end
