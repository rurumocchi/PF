require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:ogiri) { create(:ogiri, user: user) }
  let!(:other_ogiri) { create(:ogiri, user: other_user) }
  let!(:ogiri_odai) { create(:ogiri_odai, user: user) }
  let!(:other_ogiri_odai) { create(:ogiri_odai, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    subject { current_path }
    it '大喜利一覧を押すと、大喜利一覧画面に遷移する' do
      ogiris_link = find_all('a')[1].native.inner_text
      ogiris_link = ogiris_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link ogiris_link
      is_expected.to eq '/ogiris'
    end

    it '検索を押すと、検索一覧画面に遷移する' do
      search_top_link = find_all('a')[3].native.inner_text
      search_top_link = search_top_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link search_top_link
      is_expected.to eq '/home/search_top'
    end
    it 'ランキングを押すと、大喜利いいねランキング一覧画面に遷移する' do
      favorite_rank_link = find_all('a')[4].native.inner_text
      favorite_rank_link = favorite_rank_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link favorite_rank_link
      is_expected.to eq '/ogiris/favorite_rank'
    end
  end

   describe '投稿一覧画面のテスト' do
    before do
      visit new_ogiri_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiris/new'
      end
    end
    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it '「編集する」と表示される' do
        expect(page).to have_content '編集する'
      end
       it '「大喜利を投稿する」と表示される' do
        expect(page).to have_content '大喜利を投稿する'
      end
       it '「お題を投稿する」と表示される' do
        expect(page).to have_content 'お題を投稿する'
      end
       it '「いいね一覧」と表示される' do
        expect(page).to have_content 'いいね一覧'
      end
    end
    context '大喜利投稿成功のテスト' do
      before do
        fill_in 'ogiri[answer]', with: Faker::Lorem.characters(number: 15)
        fill_in 'ogiri[ogiri_odai]', with: Faker::Lorem.characters(number: 20)
      end
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.ogiris, :count).by(1)
      end
      it 'リダイレクト先が、大喜利一覧画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/ogiris'
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit ogiri_path(ogiri)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiris/' + ogiri.id.to_s
      end
      it '「大喜利詳細」と表示される' do
        expect(page).to have_content '大喜利詳細'
      end
      it '投稿の回答が表示される' do
        expect(page).to have_content ogiri.answer
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link 'Destroy', href: ogiri_path(ogiri)
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧に自分の投稿の回答が表示され、リンクが正しい' do
        expect(page).to have_link ogiri.answer, href: ogiri_path(ogiri)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '変更するが表示される' do
        expect(page).to have_button '変更する'
      end
    end
    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更する'
      end
      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

end