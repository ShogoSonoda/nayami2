module Api
  module V1
    class MessagesController < ApplicationController
      def create
        message = current_user.messages.create!(room_id: params[:room_id], text: params[:text])
        render json: { message: message }
      end
    end
  end
end
