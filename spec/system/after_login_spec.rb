require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:ogiri) { create(:ogiri, user: user) }
  let!(:other_ogiri) { create(:ogiri, user: other_user) }
  let!(:ogiri_odai) { create(:ogiri_odai, user: user) }
  let!(:other_ogiri_odai) { create(:ogiri_odai, user: other_user) }
  let!(:ogiri_answer) { create(:ogiri_answer, ogiri_odai: ogiri_odai, user: user) }
  let!(:other_ogiri_answer) { create(:ogiri_answer, ogiri_odai: other_ogiri_odai, user: other_user) }

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

  describe '大喜利投稿一覧画面のテスト' do
    before do
      visit ogiris_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiris'
      end
      it '大喜利一覧が表示される' do
        expect(page).to have_content '大喜利一覧'
      end
      it 'お題一覧が表示される' do
        expect(page).to have_content 'お題一覧'
        expect(page).to have_link 'お題一覧', href: ogiri_odais_path
      end
      it '自分の投稿と他人の投稿の画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link "", href: user_path(ogiri.user)
        expect(page).to have_link "", href: user_path(other_ogiri.user)
      end
      it '自分の投稿と他人の投稿の名前のリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
        expect(page).to have_link other_ogiri.user.name, href: user_path(other_ogiri.user)
      end
      it '自分の投稿と他人の投稿のanswerのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.answer, href: ogiri_path(ogiri)
        expect(page).to have_link other_ogiri.answer, href: ogiri_path(other_ogiri)
      end
      it '自分の投稿と他人の投稿のogiri_odaiのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.ogiri_odai, href: ogiri_path(ogiri)
        expect(page).to have_link other_ogiri.ogiri_odai, href: ogiri_path(other_ogiri)
      end
      it '自分の投稿と他人の投稿のカテゴリーのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
        expect(page).to have_link other_ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
      end
      it '自分の投稿と他人の投稿の大喜利詳細のリンク先がそれぞれ正しい' do
        expect(page).to have_link "大喜利詳細", href: ogiri_path(ogiri)
        expect(page).to have_link "大喜利詳細", href: ogiri_path(other_ogiri)
      end
    end
  end

  describe 'お題投稿一覧画面のテスト' do
    before do
      visit ogiri_odais_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiri_odais'
      end
      it 'お題一覧が表示される' do
        expect(page).to have_content 'お題一覧'
      end
      it '大喜利一覧が表示される' do
        expect(page).to have_link '大喜利一覧', href: ogiris_path
      end
       it '自分の投稿と他人の投稿の画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link "", href: user_path(ogiri_odai.user)
        expect(page).to have_link "", href: user_path(other_ogiri_odai.user)
      end
      it '自分の投稿と他人の投稿の名前のリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.user.name, href: user_path(ogiri_odai.user)
        expect(page).to have_link other_ogiri_odai.user.name, href: user_path(other_ogiri_odai.user)
      end
      it '自分の投稿と他人の投稿のodai_textのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.odai_text, href: ogiri_odai_path(ogiri_odai)
        expect(page).to have_link other_ogiri_odai.odai_text, href: ogiri_odai_path(other_ogiri_odai)
      end
      it '自分の投稿と他人の投稿のカテゴリーのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
        expect(page).to have_link other_ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
      end
      it '自分の投稿と他人の投稿のお題詳細 & 回答へのリンク先がそれぞれ正しい' do
        expect(page).to have_link "お題詳細 & 回答", href: ogiri_odai_path(ogiri_odai)
        expect(page).to have_link "お題詳細 & 回答", href: ogiri_odai_path(other_ogiri_odai)
      end
    end
  end

  describe '検索画面のテスト' do
    before do
      visit home_search_top_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/home/search_top'
      end
      it '大喜利ジャンル検索BOXが表示される' do
        expect(page).to have_content '大喜利ジャンル検索BOX'
      end
      it '写真で一言へのリンクが存在する' do
        expect(page).to have_link '写真で一言', href: search_genre_path('keyword': "写真で一言", 'search[how]': "match")
      end
      it '画像でボケてへのリンクが存在する' do
        expect(page).to have_link '画像でボケて', href: search_genre_path('keyword': "画像でボケて", 'search[how]': "match")
      end
      it 'お題で一言へのリンクが存在する' do
        expect(page).to have_link 'お題で一言', href: search_genre_path('keyword': "お題で一言", 'search[how]': "match")
      end
      it 'その他へのリンクが存在する' do
        expect(page).to have_link 'その他', href: search_genre_path('keyword': "その他", 'search[how]': "match")
      end
      it 'お題ジャンル検索BOXが表示される' do
        expect(page).to have_content 'お題ジャンル検索BOX'
      end
      it '写真で一言へのリンクが存在する' do
        expect(page).to have_link '写真で一言', href: search_genre_odai_path('keyword': "写真で一言", 'search[how]': "match")
      end
      it '画像でボケてへのリンクが存在する' do
        expect(page).to have_link '画像でボケて', href: search_genre_odai_path('keyword': "画像でボケて", 'search[how]': "match")
      end
      it 'お題で一言へのリンクが存在する' do
        expect(page).to have_link 'お題で一言', href: search_genre_odai_path('keyword': "お題で一言", 'search[how]': "match")
      end
      it 'その他へのリンクが存在する' do
        expect(page).to have_link 'その他', href: search_genre_odai_path('keyword': "その他", 'search[how]': "match")
      end
    end
  end

  describe '大喜利いいねランキング画面のテスト' do
    before do
      visit favorite_rank_ogiris_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiris/favorite_rank'
      end
      it '大喜利いいねランキングが表示される' do
        expect(page).to have_content '大喜利いいねランキング'
      end
      it 'お題いいねランキング' do
        expect(page).to have_link 'お題いいねランキング', href: odai_favorite_rank_ogiri_odais_path
      end
      it '自分の投稿と他人の投稿の画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link "", href: user_path(ogiri.user)
        expect(page).to have_link "", href: user_path(other_ogiri.user)
      end
      it '自分の投稿と他人の投稿の名前のリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
        expect(page).to have_link other_ogiri.user.name, href: user_path(other_ogiri.user)
      end
      it '自分の投稿と他人の投稿のanswerのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.answer, href: ogiri_path(ogiri)
        expect(page).to have_link other_ogiri.answer, href: ogiri_path(other_ogiri)
      end
      it '自分の投稿と他人の投稿のogiri_odaiのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.ogiri_odai, href: ogiri_path(ogiri)
        expect(page).to have_link other_ogiri.ogiri_odai, href: ogiri_path(other_ogiri)
      end
      it '自分の投稿と他人の投稿のカテゴリーのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
        expect(page).to have_link other_ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
      end
      it '自分の投稿と他人の投稿の大喜利詳細のリンク先がそれぞれ正しい' do
        expect(page).to have_link "大喜利詳細", href: ogiri_path(ogiri)
        expect(page).to have_link "大喜利詳細", href: ogiri_path(other_ogiri)
      end
    end
  end

  describe 'お題いいねランキング画面のテスト' do
    before do
      visit odai_favorite_rank_ogiri_odais_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiri_odais/odai_favorite_rank'
      end
      it 'お題いいねランキングが表示される' do
        expect(page).to have_content 'お題いいねランキング'
      end
      it '大喜利いいねランキング' do
        expect(page).to have_link '大喜利いいねランキング', href: favorite_rank_ogiris_path
      end
      it '自分の投稿と他人の投稿の画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link "", href: user_path(ogiri_odai.user)
        expect(page).to have_link "", href: user_path(other_ogiri_odai.user)
      end
      it '自分の投稿と他人の投稿の名前のリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.user.name, href: user_path(ogiri_odai.user)
        expect(page).to have_link other_ogiri_odai.user.name, href: user_path(other_ogiri_odai.user)
      end
      it '自分の投稿と他人の投稿のodai_textのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.odai_text, href: ogiri_odai_path(ogiri_odai)
        expect(page).to have_link other_ogiri_odai.odai_text, href: ogiri_odai_path(other_ogiri_odai)
      end
      it '自分の投稿と他人の投稿のカテゴリーのリンク先がそれぞれ正しい' do
        expect(page).to have_link ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
        expect(page).to have_link other_ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
      end
      it '自分の投稿と他人の投稿のお題詳細 & 回答へのリンク先がそれぞれ正しい' do
        expect(page).to have_link "お題詳細 & 回答", href: ogiri_odai_path(ogiri_odai)
        expect(page).to have_link "お題詳細 & 回答", href: ogiri_odai_path(other_ogiri_odai)
      end
    end
  end

   describe '投稿画面のテスト' do
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
      it '検索フォームが表示される' do
        expect(page).to have_field 'search'
      end
      it '自分のフォローへのリンクが存在する' do
        expect(page).to have_link user.followings.count, href: user_followings_path(user)
      end
      it '自分のフォロワーへのリンクが存在する' do
        expect(page).to have_link user.followers.count, href: user_followers_path(user)
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '編集する', href: edit_user_path(user)
      end
       it '「大喜利を投稿する」と表示される' do
        expect(page).to have_link '大喜利を投稿する', href: new_ogiri_path
      end
       it '「お題を投稿する」と表示される' do
        expect(page).to have_link 'お題を投稿する', href: new_ogiri_odai_path
      end
       it '「いいね一覧」と表示される' do
        expect(page).to have_link 'いいね一覧', href: favorites_user_path(user)
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

  describe 'お題投稿画面のテスト' do
    before do
      visit new_ogiri_odai_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiri_odais/new'
      end
    end
    context 'お題投稿成功のテスト' do
      before do
        fill_in 'ogiri_odai[odai_text]', with: Faker::Lorem.characters(number: 20)
      end
      it '自分の新しいお題投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.ogiri_odais, :count).by(1)
      end
      it 'リダイレクト先が、お題一覧画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/ogiri_odais'
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
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
      end
      it '投稿の回答が表示される' do
        expect(page).to have_content ogiri.answer
      end
      it 'カテゴリーリンクが表示される' do
        expect(page).to have_link ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link 'Destroy', href: ogiri_path(ogiri)
      end
    end
  end

  describe '自分のお題投稿詳細画面のテスト' do
    before do
      visit ogiri_odai_path(ogiri_odai)
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ogiri_odais/' + ogiri_odai.id.to_s
      end
      it 'お題詳細 & 回答と表示される' do
        expect(page).to have_content 'お題詳細 & 回答'
      end
      it 'お題一覧が表示される' do
        expect(page).to have_link 'お題一覧', href: ogiri_odais_path
      end
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri_odai.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri_odai.user.name, href: user_path(ogiri_odai.user)
      end
      it '投稿のお題が表示される' do
        expect(page).to have_content ogiri_odai.odai_text
      end
      it '投稿のお題が表示される' do
        expect(page).to have_content ogiri_odai.odai_image_id
      end
      it 'カテゴリーリンクが表示される' do
        expect(page).to have_link ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
      end
      it 'お題詳細 & 回答へ→リンクが表示される' do
        expect(page).to have_link 'お題詳細 & 回答へ→', href: ogiri_odai_path(ogiri_answer.ogiri_odai)
      end
      it '回答するリンクが表示される' do
        expect(page).to have_link '回答する', href: new_ogiri_odai_ogiri_answer_path(ogiri_odai)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link 'Destroy', href: ogiri_odai_path(ogiri_odai)
      end
      it '回答一覧と表示される' do
        expect(page).to have_content '回答一覧'
      end
      it '回答者ユーザアイコンが表示される' do
        expect(page).to have_link '', href: user_path(ogiri_answer.user)
      end
      it '回答者ユーザが表示される' do
        expect(page).to have_link ogiri_answer.user.name, href: user_path(ogiri_answer.user)
      end
      it 'お題の回答が表示される' do
        expect(page).to have_link ogiri_answer.ogiri_answer, href: ogiri_odai_ogiri_answer_path(ogiri_answer.ogiri_odai_id, ogiri_answer.id)
      end
      it '回答の削除リンクが表示される' do
        expect(page).to have_link 'Destroy', href: ogiri_odai_ogiri_answer_path(ogiri_answer.ogiri_odai_id, ogiri_answer.id)
      end
    end
  end

  describe 'いいね一覧画面のテスト' do
    before do
      visit favorites_user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/favorites'
      end
      it 'いいねした大喜利投稿一覧が表示される' do
        expect(page).to have_content 'いいねした大喜利投稿一覧'
      end
      it 'いいねしたお題一覧が表示される' do
          expect(page).to have_link 'いいねしたお題一覧', href: odai_favorites_user_path(user)
      end
      it 'いいねした回答一覧が表示される' do
          expect(page).to have_link 'いいねした回答一覧', href: answer_favorites_user_path(user)
      end
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
      end

    end
  end

  describe 'いいねしたお題一覧画面のテスト' do
    before do
      visit odai_favorites_user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/odai_favorites'
      end
      it 'いいねしたお題投稿一覧が表示される' do
        expect(page).to have_content 'いいねしたお題一覧'
      end
      it 'いいねした大喜利一覧が表示される' do
          expect(page).to have_link 'いいねした大喜利投稿一覧', href: favorites_user_path(user)
      end
      it 'いいねした回答一覧が表示される' do
          expect(page).to have_link 'いいねした回答一覧', href: answer_favorites_user_path(user)
      end
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri_odai.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri_odai.user.name, href: user_path(ogiri_odai.user)
      end

    end
  end

  describe 'いいねした回答一覧画面のテスト' do
    before do
      visit answer_favorites_user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/answer_favorites'
      end
      it 'いいねした回答一覧が表示される' do
        expect(page).to have_content 'いいねした回答一覧'
      end
      it 'いいねした大喜利一覧が表示される' do
          expect(page).to have_link 'いいねした大喜利投稿一覧', href: favorites_user_path(user)
      end
      it 'いいねしたお題一覧が表示される' do
          expect(page).to have_link 'いいねしたお題一覧', href: odai_favorites_user_path(user)
      end
      it '回答者ユーザアイコンが表示される' do
        expect(page).to have_link '', href: user_path(ogiri_answer.user)
      end
      it '回答者ユーザが表示される' do
        expect(page).to have_link ogiri_answer.user.name, href: user_path(ogiri_answer.user)
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
      it '投稿した大喜利一覧が表示される' do
        expect(page).to have_content '投稿した大喜利'
      end
      it '投稿したお題一覧が表示される' do
          expect(page).to have_link '投稿したお題', href: create_odais_user_path(user)
      end
      it '投稿した回答一覧が表示される' do
          expect(page).to have_link '投稿した回答', href: create_answers_user_path(user)
      end
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri.user.name, href: user_path(ogiri.user)
      end
      it '投稿の回答が表示される' do
        expect(page).to have_link ogiri.answer, href: ogiri_path(ogiri)
      end
      it 'カテゴリーリンクが表示される' do
        expect(page).to have_link ogiri.genre_name, href: search_genre_path(keyword: ogiri.genre_name)
      end
      it '投稿一覧に自分の投稿の回答が表示され、リンクが正しい' do
        expect(page).to have_link ogiri.answer, href: ogiri_path(ogiri)
      end
    end
  end

  describe '自分の投稿したお題のテスト' do
    before do
      visit create_odais_user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/create_odais'
      end
      it '投稿したお題一覧が表示される' do
        expect(page).to have_content '投稿したお題'
      end
      it '投稿した大喜利一覧が表示される' do
          expect(page).to have_link '投稿した大喜利', href: user_path(user)
      end
      it '投稿した回答一覧が表示される' do
          expect(page).to have_link '投稿した回答', href: create_answers_user_path(user)
      end
      it '大喜利ユーザアイコンが表示される' do
        expect(page).to have_link "", href: user_path(ogiri_odai.user)
      end
      it '大喜利ユーザが表示される' do
        expect(page).to have_link ogiri_odai.user.name, href: user_path(ogiri_odai.user)
      end
      it '投稿のお題が表示される' do
        expect(page).to have_content ogiri_odai.odai_text
      end
      it '投稿のお題が表示される' do
        expect(page).to have_content ogiri_odai.odai_image_id
      end
      it 'カテゴリーリンクが表示される' do
        expect(page).to have_link ogiri_odai.genre_name, href: search_genre_odai_path(keyword: ogiri_odai.genre_name)
      end
      it 'お題詳細 & 回答へ→リンクが表示される' do
        expect(page).to have_link 'お題詳細 & 回答へ→', href: ogiri_odai_path(ogiri_answer.ogiri_odai)
      end
    end
  end

  describe '自分の投稿した回答画面のテスト' do
    before do
      visit create_answers_user_path(user)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/create_answers'
      end
      it '投稿したお題一覧が表示される' do
        expect(page).to have_content '投稿したお題'
      end
      it '投稿した大喜利一覧が表示される' do
          expect(page).to have_link '投稿した大喜利', href: user_path(user)
      end
      it '投稿したお題一覧が表示される' do
          expect(page).to have_link '投稿したお題', href: create_odais_user_path(user)
      end
      it '回答者ユーザアイコンが表示される' do
        expect(page).to have_link '', href: user_path(ogiri_answer.user)
      end
      it '回答者ユーザが表示される' do
        expect(page).to have_link ogiri_answer.user.name, href: user_path(ogiri_answer.user)
      end

      it 'お題詳細 & 回答へ→リンクが表示される' do
        expect(page).to have_link 'お題詳細 & 回答へ→', href: ogiri_odai_path(ogiri_answer.ogiri_odai)
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