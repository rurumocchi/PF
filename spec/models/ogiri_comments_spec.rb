require 'rails_helper'

RSpec.describe OgiriComment, type: :model do
  before do
    @ogiri_comment = build(:ogiri_comment)
  end

  describe 'バリデーション' do
    it 'commentが空だとNG' do
      @ogiri_comment.comment = ''
      expect(@ogiri_comment.valid?).to eq(false)
    end
    it 'commentが100文字以下であること: 100文字は〇' do
      @ogiri_comment.comment = Faker::Lorem.characters(number: 100)
      expect(@ogiri_comment.invalid?).to eq true
    end
    it 'commentが100文字以下であること: 101文字は×' do
      @ogiri_comment.comment = Faker::Lorem.characters(number: 101)
      expect(@ogiri_comment.valid?).to eq false
    end
    it 'rankが空だとNG' do
      @ogiri_comment.rate = ''
      expect(@ogiri_comment.valid?).to eq(false)
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:ogiri_comments).macro).to eq :has_many
      end
    end
    context 'ogiriモデルとの関係' do
      it '1:Nとなっている' do
        expect(Ogiri.reflect_on_association(:ogiri_comments).macro).to eq :has_many
      end
    end
  end
end
