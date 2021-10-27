require 'rails_helper'

RSpec.describe OgiriOdai, type: :model do
  before do
    @ogiri_odai = build(:ogiri_odai)
  end

  describe 'バリデーション' do
    it 'odai_textが空だとNG' do
      @ogiri_odai.odai_text = ''
      expect(@ogiri_odai.valid?).to eq(false)
    end
    it 'user_idが空だとNG' do
      @ogiri_odai.user_id = ''
      expect(@ogiri_odai.valid?).to eq(false)
    end
    it 'odai_image_idが空だとNG' do
      @ogiri_odai.odai_image_id = ''
      expect(@ogiri_odai.valid?).to eq(false)
    end
    it 'ogiri_odai_selectが空だとNG' do
      @ogiri_odai.ogiri_odai_select = ''
      expect(@ogiri_odai.valid?).to eq(false)
    end
    it 'genre_nameが空だとNG' do
      @ogiri_odai.genre_name = ''
      expect(@ogiri_odai.valid?).to eq(false)
    end
    it 'odai_textが75文字以下であること: 75文字は〇' do
       @ogiri_odai.odai_text = Faker::Lorem.characters(number: 75)
       expect(@ogiri_odai.invalid?).to eq true
    end
    it 'odai_textが75文字以下であること: 76文字は×' do
      @ogiri_odai.odai_text = Faker::Lorem.characters(number: 76)
      expect(@ogiri_odai.valid?).to eq false
    end

  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:ogiri_odais).macro).to eq :has_many
      end
    end
     context 'odai_favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(OdaiFavorite.reflect_on_association(:ogiri_odai).macro).to eq :belongs_to
      end
    end
     context 'ogiri_answerモデルとの関係' do
      it 'N:1となっている' do
        expect(OgiriAnswer.reflect_on_association(:ogiri_odai).macro).to eq :belongs_to
      end
    end
  end

end