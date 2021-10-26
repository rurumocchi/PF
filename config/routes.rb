Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "home/search_top" => "homes#search_top"
  get "/search" => "searches#search"
  get "search_genre" => "categories#search_genre"
  get "search_genre_odai"  => "categories#search_genre_odai"

  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
      get :odai_favorites
      get :answer_favorites
      get :create_odais
      get :create_answers
    end

    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :ogiris, only: [:new, :index, :show, :create, :destroy] do
    collection do
      get :favorite_rank
    end
    resource :favorites, only: [:create, :destroy]
    resources :ogiri_comments, only: [:create, :destroy]
  end

  resources :ogiri_odais, only: [:new, :index, :show, :create, :destroy] do
    collection do
      get :odai_favorite_rank
    end
    resource :odai_favorites, only: [:create, :destroy]
    resources :ogiri_answers, only: [:new, :show, :create, :destroy] do
      collection do
       get :answer_favorite_rank
      end
      resource :answer_favorites, only: [:create, :destroy]
    end
  end

end
