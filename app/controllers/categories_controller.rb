class CategoriesController < ApplicationController

  def search_genre
    @ogiri = Ogiri.new
    @ogiris = Ogiri.search_genre(params[:keyword]).page(params[:page]).per(5).order(created_at: :desc) #大喜利ジャンル検索一覧（新しい順に並べる）
  end

  def search_genre_odai
    @ogiri_odai = OgiriOdai.new
    @ogiri_odais = OgiriOdai.search_genre_odai(params[:keyword]).page(params[:page]).per(5).order(created_at: :desc) #お題ジャンル検索一覧（新しい順に並べる）
  end


end
