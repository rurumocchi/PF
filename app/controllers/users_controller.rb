class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:favorites, :odai_favorites, :answer_favorites]

  def show
    @user = User.find(params[:id])
    @ogiris = @user.ogiris.all.order(created_at: :desc)
  end

  def create_odais
    @user = User.find(params[:id])
    @ogiri_odais = @user.ogiri_odais.all.order(created_at: :desc)
  end

  def create_answers
    @user = User.find(params[:id])
    @ogiri_answers = @user.ogiri_answers.all.order(created_at: :desc)
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def odai_favorites
    @user = User.find(params[:id])
    #@ogiri_odais = @user.ogiri_odais.all
    odai_favorites = OdaiFavorite.where(user_id: @user.id).pluck(:ogiri_odai_id)
    @favorite_odais = OgiriOdai.find(odai_favorites)
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:ogiri_id)
    @favorite_ogiris = Ogiri.find(favorites)
    #@ogiris = Ogiri.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    #@favorite_ogiris = Ogiri.find(Like.group(:ogiri_id).order('created_at(ogiri_id) desc').pluck(:ogiri_id))
  end

  def answer_favorites
    @user = User.find(params[:id])
    answer_favorites = AnswerFavorite.where(user_id: @user.id).pluck(:ogiri_answer_id)
    @favorite_answers = OgiriAnswer.find(answer_favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
