require 'rails_helper'

RSpec.describe Ogiri, type: :model do
  before do
    @ogiri = build(:ogiri)
  end

  describe 'バリデーション' do
    it 'user_idが空だとNG' do
      @ogiri.user_id = ''
      expect(@ogiri.valid?).to eq(false)
    end
    it 'answerが空だとNG' do
      @ogiri.answer = ''
      expect(@ogiri.valid?).to eq(false)
    end
    it 'ogiri_odaiが空だとNG' do
      @ogiri.ogiri_odai = ''
      expect(@ogiri.valid?).to eq(false)
    end
    it 'genre_nameが空だとNG' do
      @ogiri.genre_name = ''
      expect(@ogiri.valid?).to eq(false)
    end
    it 'image_idが空だとNG' do
      @ogiri.image_id = ''
      expect(@ogiri.valid?).to eq(false)
    end
    it 'ogiri_selectが空だとNG' do
      @ogiri.ogiri_select = ''
      expect(@ogiri.valid?).to eq(false)
    end

    it 'answerが100文字以下であること: 100文字は〇' do
      @ogiri.answer = Faker::Lorem.characters(number: 100)
      expect(@ogiri.invalid?).to eq(true)
    end
    it 'answerが100文字以下であること: 101文字は×' do
      @ogiri.answer = Faker::Lorem.characters(number: 101)
      expect(@ogiri.valid?).to eq(false)
    end
    it 'ogiri_commentが75文字以下であること: 75文字は〇' do
      @ogiri.ogiri_odai = Faker::Lorem.characters(number: 75)
      expect(@ogiri.invalid?).to eq(true)
    end
    it 'answerが75文字以下であること: 76文字は×' do
      @ogiri.ogiri_odai = Faker::Lorem.characters(number: 76)
      expect(@ogiri.valid?).to eq(false)
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:ogiris).macro).to eq :has_many
      end
    end
    context 'favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:ogiri).macro).to eq :belongs_to
      end
    end
    context 'ogiri_commentモデルとの関係' do
      it 'N:1となっている' do
        expect(OgiriComment.reflect_on_association(:ogiri).macro).to eq :belongs_to
      end
    end
  end
end
