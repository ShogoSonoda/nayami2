class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :position

  validates :nickname, presence: true
  validates :profile, length: { maximum: 200 }
end
