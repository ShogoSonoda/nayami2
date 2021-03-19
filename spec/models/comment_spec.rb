require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = create(:user)
    post = create(:post, user_id: user.id)
    @comment = create(:comment, user_id: user.id, post_id: post.id)
  end

  context 'コメントを送ることができる場合' do
    it 'text,user_id,post_idが存在すればコメントを送信できる' do
      expect(@comment).to be_valid
    end
  end
  
  context 'コメントを送ることができない場合' do
    it 'textが空だとコメントを送信できない' do
      @comment.text = ""
      @comment.valid?
      expect(@comment).to be_invalid
    end

    it 'user_idが空だとコメントを送信できない' do
      @comment.user_id = ""
      @comment.valid?
      expect(@comment).to be_invalid
    end

    it 'post_idが空だとコメントを送信できない' do
      @comment.post_id = ""
      @comment.valid?
      expect(@comment).to be_invalid
    end
  end
end
