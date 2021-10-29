require 'rails_helper'


describe '[STEP1] ユーザログイン前のテスト' do
  describe 'ホーム画面のテスト' do
    before do
      visit root_path
    end

     context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end

   describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do

      it 'タイトルが表示される' do
        expect(page).to have_content 'お手軽大喜利'
      end

      it 'Homeリンクが表示される: 左上から1番目のリンクが「Home」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match(/home/i)
      end

      it '新規登録リンクが表示される: 左上から2番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[2].native.inner_text
        expect(signup_link).to match(/新規登録/i)
      end
      it 'ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である' do
        login_link = find_all('a')[3].native.inner_text
        expect(login_link).to match(/ログイン/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Homeを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[2].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
    end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

     context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end
    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、大喜利の一覧画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/ogiris'
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'user[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先が、大喜利一覧画面になっている' do
        expect(current_path).to eq '/ogiris'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
   end

    describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'お手軽大喜利'
      end
      it '大喜利一覧リンクが表示される: 左上から1番目のリンクが「大喜利一覧」である' do
        ogiri_link = find_all('a')[1].native.inner_text
        expect(ogiri_link).to match(/大喜利一覧/i)
      end
       it 'お題一覧リンクが表示される: 左上から2番目のリンクが「お題一覧」である' do
        ogiri_odai_link = find_all('a')[2].native.inner_text
        expect(ogiri_odai_link).to match(/お題一覧/i)
      end
      it '検索リンクが表示される: 左上から3番目のリンクが「検索」である' do
        search_top_link = find_all('a')[3].native.inner_text
        expect(search_top_link).to match(/検索/i)
      end
      it 'ランキングリンクが表示される: 左上から4番目のリンクが「ランキング」である' do
        favorite_rank_link = find_all('a')[4].native.inner_text
        expect(favorite_rank_link).to match(/ランキング/i)
      end
      it 'ログアウトtリンクが表示される: 左上から5番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match(/ログアウト/i)
      end
    end
   end

   describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[4].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end
    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている' do
        expect(page).to have_link ''
      end
    end
  end

  end
end