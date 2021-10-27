require 'rails_helper'

RSpec.describe AnswerFavorite, type: :model do

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:answer_favorites).macro).to eq :has_many
      end
    end
    context 'ogiri_answerモデルとの関係' do
      it '1:Nとなっている' do
        expect(OgiriAnswer.reflect_on_association(:answer_favorites).macro).to eq :has_many
      end
    end
  end
end