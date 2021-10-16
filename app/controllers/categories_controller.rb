class CategoriesController < ApplicationController

  def search_genre
    @ogiri = Ogiri.new
    @ogiris = Ogiri.all
    @ogiris = Ogiri.search_genre(params[:keyword])
  end

end
