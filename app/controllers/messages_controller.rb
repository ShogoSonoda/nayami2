class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    return unless Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?

    @message = Message.new(message_params)
    @room = @message.room

    return unless @message.save

    @roomMemberNotMe = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
    @theId = @roomMemberNotMe.find_by(room_id: @room.id)
    notification = current_user.active_notifications.new(
      room_id: @room.id,
      message_id: @message.id,
      visited_id: @theId.user_id,
      visitor_id: current_user.id,
      action: 'dm'
    )

    return unless notification.visitor_id == notification.visited_id
    
    notification.checked = true
    notification.save if notification.valid?
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :text).merge(user_id: current_user.id)
  end
end
