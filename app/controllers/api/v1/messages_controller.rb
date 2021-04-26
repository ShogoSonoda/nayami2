module Api
  module V1
    class MessagesController < ApplicationController
      def create
        message = current_user.messages.create!(room_id: params[:room_id], text: params[:text])
        room = message.room
        dm_entry_table = Entry.where(room_id: room.id).where.not(user_id: current_user.id)
        dm_entry = dm_entry_table.find_by(room_id: room.id)
        notification = current_user.active_notifications.new(
          room_id: room.id,
          message_id: message.id,
          visited_id: dm_entry.user_id,
          visitor_id: current_user.id,
          action: 'dm'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save
        render json: { message: message, user_name: current_user.nickname }
      end
    end
  end
end
