class OgirisController < ApplicationController
  before_action :authenticate_user!


  def new
    @ogiri = Ogiri.new
    @users = User.all
  end

  def index
    @ogiris = Ogiri.all
    @ogiris = Ogiri.all.order(params[:sort])
  end

  def create
    @ogiri = Ogiri.new(ogiri_params)
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

  private

  def ogiri_params
    params.require(:ogiri).permit(:answer, :image, :rate, :category)
  end

  def ensure_correct_user
    @ogiri = Ogiri.find(params[:id])
    unless @ogiri.user == current_user
      redirect_to ogiris_path
    end
  end

end
