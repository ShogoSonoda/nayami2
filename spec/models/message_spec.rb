require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    user = create(:user)
    room = Room.create
    @message = create(:message, user_id: user.id, room_id: room.id)
  end

  context 'メッセージを送信できる場合' do
    it 'text,user_id,room_idが存在すれば送信できる' do
      expect(@message).to be_valid
    end
  end
  
  context 'メッセージを送信できない場合' do
    it 'textが空だと送信できない' do
      @message.text = ""
      @message.valid?
      expect(@message).to be_invalid
    end
    
    it 'user_idが空だと送信できない' do
      @message.user_id = ""
      @message.valid?
      expect(@message).to be_invalid
    end

    it 'room_idが空だと送信できない' do
      @message.room_id = ""
      @message.valid?
      expect(@message).to be_invalid
    end
  end
end
