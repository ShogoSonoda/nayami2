require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = Tag.create(name: "転職")
  end

  context 'タグを保存できる場合' do
    it "nameがあればタグ登録できる" do
      expect(@tag).to be_valid
    end
  end

  context 'タグを保存できない場合' do
    it "nameがないとタグ登録できない" do
      @tag.name = ""
      @tag.valid?
      expect(@tag).to be_invalid
    end

    it "nameが51文字以上だとタグ登録できない" do
      @tag.name = "あ" * 51
      @tag.valid?
      expect(@tag).to be_invalid
    end

    it "同じnameは保存されない" do
      another_tag = Tag.new
      another_tag.name = @tag.name
      another_tag.save
      another_tag.valid?
      expect(another_tag).to be_invalid
    end
  end
end
