class CategoriesController < ApplicationController

  def search_genre
    @ogiri = Ogiri.new
    @ogiris = Ogiri.search_genre(params[:keyword]).order(created_at: :desc)
  end

end
