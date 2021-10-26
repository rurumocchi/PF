Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #ホーム画面「/」
  root :to => "homes#top"
  #アバウト画面
  get "home/about" => "homes#about"
   #検索BOX画面
  get "home/search_top" => "homes#search_top"
   #ユーザ検索
  get "/search" => "searches#search"
   #ジャンル検索(大喜利)
  get "search_genre" => "categories#search_genre"
   #ジャンル検索(お題)
  get "search_genre_odai"  => "categories#search_genre_odai"
  
   #ユーザ詳細、編集、更新
  resources :users, only: [:show, :edit, :update] do
    member do
       #いいねした大喜利一覧
      get :favorites
       #いいねしたお題一覧
      get :odai_favorites
       #いいねした回答一覧
      get :answer_favorites
       #投稿したお題一覧
      get :create_odais
      #投稿した回答一覧
      get :create_answers
    end
    
    #ユーザフォロー機能
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  #大喜利投稿、一覧、詳細、削除
  resources :ogiris, only: [:new, :index, :show, :create, :destroy] do
    collection do
      #大喜利いいねランキング
      get :favorite_rank
    end
    #大喜利いいね機能
    resource :favorites, only: [:create, :destroy]
    #大喜利コメント機能
    resources :ogiri_comments, only: [:create, :destroy]
  end
  #お題投稿、一覧、詳細、削除
  resources :ogiri_odais, only: [:new, :index, :show, :create, :destroy] do
    collection do
      #お題いいねランキング
      get :odai_favorite_rank
    end
    #お題いいね機能
    resource :odai_favorites, only: [:create, :destroy]
    #回答投稿、詳細、削除
    resources :ogiri_answers, only: [:new, :show, :create, :destroy] do
      collection do
        #回答いいねランキング
       get :answer_favorite_rank
      end
      #回答いいね機能
      resource :answer_favorites, only: [:create, :destroy]
    end
  end

end
