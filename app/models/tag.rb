class Tag < ApplicationRecord
  has_many :posts, through: :post_tags
  has_many :post_tags, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :name, uniqueness: true
end
