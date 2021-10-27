require 'rails_helper'

RSpec.describe Favorite, type: :model do


  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'ogiriモデルとの関係' do
      it '1:Nとなっている' do
        expect(Ogiri.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end