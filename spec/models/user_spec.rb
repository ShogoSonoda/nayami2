require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = create(:user)
  end

  context 'ユーザー新規登録できる場合' do
    it "nickname,email,password,password_confirmationがあれば新規登録できる" do
      expect(@user).to be_valid
    end
  end

  context 'ユーザー新規登録できない場合' do
    it "nicknameがないと新規登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "emailがないと新規登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "passwordがないと新規登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "password_confirmationがないと新規登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "すでに登録されているemailだと新規登録できない" do
      another_user = create(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user).to be_invalid
    end
    
    it "passwordとpassword_confirmationが一致しないと新規登録できない" do
      @user.password = "222222"
      @user.password_confirmation = "111111"
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "passwordが6文字未満だと新規登録できない" do
      @user.password = "12345"
      @user.valid?
      expect(@user).to be_invalid
    end
    
    it "profileは200文字超えると登録できない" do
      @user.profile = "あ" * 201
      @user.valid?
      expect(@user).to be_invalid
    end
  end
end
