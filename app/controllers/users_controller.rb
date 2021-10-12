class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @ogiris = @user.ogiris
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
