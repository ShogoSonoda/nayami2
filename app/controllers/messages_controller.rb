class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :text).merge(user_id: current_user.id)
  end
end
