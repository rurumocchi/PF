require 'rails_helper'

RSpec.describe OgiriAnswer, type: :model do
  before do
    @ogiri_answer = build(:ogiri_answer)
  end

  describe 'バリデーション' do
    it 'ogiri_answerが空だとNG' do
      @ogiri_answer.ogiri_answer = ''
      expect(@ogiri_answer.valid?).to eq(false)
    end
    it 'ogiri_answerが100文字以下であること: 100文字は〇' do
      @ogiri_answer.ogiri_answer = Faker::Lorem.characters(number: 100)
      expect(@ogiri_answer.invalid?).to eq true
    end
    it 'ogiri_answerが100文字以下であること: 101文字は×' do
      @ogiri_answer.ogiri_answer = Faker::Lorem.characters(number: 101)
      expect(@ogiri_answer.valid?).to eq false
    end
  end

  describe 'アソシエーションのテスト' do
    context 'answer_favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(AnswerFavorite.reflect_on_association(:ogiri_answer).macro).to eq :belongs_to
      end
    end
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:ogiri_answers).macro).to eq :has_many
      end
    end
    context 'ogiri_odaiモデルとの関係' do
      it '1:Nとなっている' do
        expect(OgiriOdai.reflect_on_association(:ogiri_answers).macro).to eq :has_many
      end
    end
  end
end
