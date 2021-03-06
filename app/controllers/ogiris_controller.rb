class OgirisController < ApplicationController
  before_action :authenticate_user!

  def new
    @ogiri = Ogiri.new
    @users = User.all
  end

  def index
    @ogiris = Ogiri.page(params[:page]).per(5).order(created_at: :desc) # 大喜利一覧表示(新しい順)
  end

  def create
    @ogiri = Ogiri.new(ogiri_params)
    if params[:ogiri][:ogiri_select] == 'select_image'
      @ogiri.ogiri_select = params[:image]
    elsif params[:ogiri][:ogiri_select] == 'select_ogiri'
      @ogiri.ogiri_select = params[:ogiri_odai]
    end
    @ogiri.user_id = current_user.id
    if @ogiri.save!
      redirect_to ogiris_path
    else
      render 'new'
    end
  end

  def show
    @ogiri = Ogiri.find(params[:id])
    @ogiri_comment = OgiriComment.new
  end

  def destroy
    @ogiri = Ogiri.find(params[:id])
    @ogiri.destroy
    redirect_to ogiris_path
  end

  def favorite_rank
    ogiris = # 大喜利いいねランキング
      Ogiri.includes(:favorited_users).sort do |a, b|
        b.favorited_users.size <=> a.favorited_users.size
      end
    @ogiris = Kaminari.paginate_array(ogiris).page(params[:page]).per(5)
  end

  private

  def ogiri_params
    params.require(:ogiri).permit(:answer, :genre_name, :ogiri_select, :ogiri_odai, :image)
  end

  def ensure_correct_user
    @ogiri = Ogiri.find(params[:id])
    redirect_to ogiris_path unless @ogiri.user == current_user
  end
end
