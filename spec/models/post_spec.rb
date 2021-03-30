require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    user = create(:user)
    @post = create(:post, user_id: user.id)
  end

  context '悩み新規投稿できる場合' do
    it 'text,user_idが存在すれば新規投稿できる' do
      expect(@post).to be_valid
    end
  end

  context '悩み新規投稿できない場合' do
    it 'textが空のとき新規投稿できない' do
      @post.text = ""
      @post.valid?
      expect(@post).to be_invalid
    end

    it 'textが2001文字以上のとき新規投稿できない' do
      @post.text = "あ" * 2001
      @post.valid?
      expect(@post).to be_invalid
    end

    it 'user_idが空のとき新規投稿できない' do
      @post.user_id = ""
      @post.valid?
      expect(@post).to be_invalid
    end
  end
end
