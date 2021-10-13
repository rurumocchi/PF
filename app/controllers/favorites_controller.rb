class FavoritesController < ApplicationController
before_action :authenticate_user!

  def create
    @ogiri = Ogiri.find(params[:ogiri_id])
    favorite = @ogiri.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @ogiri = Ogiri.find(params[:ogiri_id])
    favorite = @ogiri.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end

end
