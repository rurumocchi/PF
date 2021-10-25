class OdaiFavoritesController < ApplicationController

  def create
    @ogiri_odai = OgiriOdai.find(params[:ogiri_odai_id])
    odai_favorite = @ogiri_odai.odai_favorites.new(user_id: current_user.id)
    odai_favorite.save
    redirect_to request.referer
  end

  def destroy
    @ogiri_odai = OgiriOdai.find(params[:ogiri_odai_id])
    odai_favorite = @ogiri_odai.odai_favorites.find_by(user_id: current_user.id)
    odai_favorite.destroy
    redirect_to request.referer
  end
end
