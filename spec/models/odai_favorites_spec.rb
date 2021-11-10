require 'rails_helper'

RSpec.describe OdaiFavorite, type: :model do
  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:odai_favorites).macro).to eq :has_many
      end
    end
    context 'ogiri_odaiモデルとの関係' do
      it '1:Nとなっている' do
        expect(OgiriOdai.reflect_on_association(:odai_favorites).macro).to eq :has_many
      end
    end
  end
end
