class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :position
  has_many :posts
  has_many :empathies, dependent: :destroy

  validates :nickname, presence: true
  validates :profile, length: { maximum: 200 }
end
