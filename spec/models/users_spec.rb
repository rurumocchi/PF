require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

   it "is invalid without an email" do
    user = User.new(
      email: nil,
      password: "user1pass",
    )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  describe 'バリデーション' do

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    it 'nameが2文字以上であること: 1文字は×' do
        @user.name = Faker::Lorem.characters(number: 1)
         expect(@user.valid?).to eq false
      end
      it 'nameが2文字以上であること: 2文字は〇' do
        @user.name = Faker::Lorem.characters(number: 2)
         expect(@user.invalid?).to eq false
      end
      it 'nameが20文字以下であること: 20文字は〇' do
        @user.name = Faker::Lorem.characters(number: 20)
         expect(@user.invalid?).to eq false
      end
      it 'nameが20文字以下であること: 21文字は×' do
        @user.name = Faker::Lorem.characters(number: 21)
        expect(@user.valid?).to eq false
      end

    it 'introductionが50文字以下であること: 50文字は〇' do
        @user.introduction = Faker::Lorem.characters(number: 50)
        expect(@user.invalid?).to eq false
      end
    it 'introductionが50文字以下であること: 51文字は×' do
        @user.introduction = Faker::Lorem.characters(number: 51)
        expect(@user.valid?).to eq false
      end

    it 'introductionが空だとNG' do
      @user.introduction = ''
      expect(@user.valid?).to eq(true)
    end

    it 'passwordが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
    end

    it 'profile_image_idが空だとNG' do
      @user.profile_image_id = ''
      expect(@user.valid?).to eq(true)
    end

  end

  describe 'アソシエーションのテスト' do
    context 'ogiriモデルとの関係' do
      it 'N:1となっている' do
        expect(Ogiri.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
      context 'ogiri_odaiモデルとの関係' do
      it 'N:1となっている' do
        expect(OgiriOdai.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'ogiri_commentモデルとの関係' do
      it 'N:1となっている' do
        expect(OgiriComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
     context 'ogiri_answerモデルとの関係' do
      it 'N:1となっている' do
        expect(OgiriAnswer.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
     context 'odai_favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(OdaiFavorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
     context 'answer_favoriteモデルとの関係' do
      it 'N:1となっている' do
        expect(AnswerFavorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end