class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @ogiris = @user.ogiris.all.order(created_at: :desc)
    #@ogiri_odais = @user.ogiri_odais.all
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

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:ogiri_id)
    @favorite_ogiris = Ogiri.find(favorites)
    #@ogiris = Ogiri.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    #@favorite_ogiris = Ogiri.find(Like.group(:ogiri_id).order('created_at(ogiri_id) desc').pluck(:ogiri_id))
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
