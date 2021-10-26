class AnswerFavoritesController < ApplicationController

  def create
    @ogiri_answer = OgiriAnswer.find(params[:ogiri_answer_id])
    answer_favorite = @ogiri_answer.answer_favorites.new(user_id: current_user.id)
    answer_favorite.save
    redirect_to request.referer
  end

  def destroy
    @ogiri_answer = OgiriAnswer.find(params[:ogiri_answer_id])
    answer_favorite = @ogiri_answer.answer_favorites.find_by(user_id: current_user.id)
    answer_favorite.destroy
    redirect_to request.referer
  end
end
