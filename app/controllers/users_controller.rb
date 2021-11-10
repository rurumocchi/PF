class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[favorites odai_favorites answer_favorites]

  def show
    @user = User.find(params[:id])
    @ogiris = @user.ogiris.page(params[:page]).per(5).order(created_at: :desc) # 投稿した大喜利一覧
  end

  def create_odais
    @user = User.find(params[:id])
    @ogiri_odais = @user.ogiri_odais.page(params[:page]).per(5).order(created_at: :desc) # 投稿したお題一覧
  end

  def create_answers
    @user = User.find(params[:id])
    @ogiri_answers = @user.ogiri_answers.page(params[:page]).per(5).order(created_at: :desc) # 投稿した回答一覧
  end

  def edit
    @user = User.find(params[:id]) # ユーザ情報編集
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def odai_favorites
    @user = User.find(params[:id])
    # @ogiri_odais = @user.ogiri_odais.all
    odai_favorites = OdaiFavorite.where(user_id: @user.id).pluck(:ogiri_odai_id)
    @favorite_odais = OgiriOdai.order(created_at: :desc).find(odai_favorites) # いいねしたお題一覧
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:ogiri_id)
    @favorite_ogiris = Ogiri.order(created_at: :desc).find(favorites) # いいねした大喜利一覧
  end

  def answer_favorites
    @user = User.find(params[:id])
    answer_favorites = AnswerFavorite.where(user_id: @user.id).pluck(:ogiri_answer_id)
    @favorite_answers = OgiriAnswer.order(created_at: :desc).find(answer_favorites) # いいねした回答一覧
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
