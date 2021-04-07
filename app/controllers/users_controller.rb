class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :search, :follows, :followers]
  before_action :set_user, only: [:show, :followings, :followers]

  def show
    @posts = @user.posts
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def search
    if params[:position_id].present?
      @users = User.where(position_id: params[:position_id]).where.not(id: current_user.id)
    else
      @users = User.all
    end
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
