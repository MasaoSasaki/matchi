require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "バリデーションチェック" do
    it "タグ名があれば有効" do
      @tag = Tag.new(name: "タグ名")
      expect(@tag).to be_valid
    end
    it "タグ名がなければ無効" do
      @tag = Tag.new(name: nil)
      expect(@tag.valid?).to eq(false)
    end
  end
end
