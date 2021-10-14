class CategoriesController < ApplicationController

  def search_category
    @ogiri = Ogiri.new
    @ogiris = Ogiri.search_category(params[:keyword])
  end

end
