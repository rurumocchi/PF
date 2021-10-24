class OgiriOdaisController < ApplicationController
  before_action :authenticate_user!

  def new
    @ogiri_odai = OgiriOdai.new
    @users = User.all
  end

  def create
    @ogiri_odai = OgiriOdai.new(ogiri_odai_params)
    @ogiri_odai.user_id = current_user.id
    if @ogiri_odai.save!
      redirect_to ogiri_odais_path
    else
       render 'new'
    end
  end

  def index
    @ogiri_odais = OgiriOdai.all.order(created_at: :desc)
  end

  def show
    @ogiri_odai = OgiriOdai.find(params[:id])
    @ogiri_answers = OgiriAnswer.all
  end

  def destroy
    @ogiri_odai = OgiriOdai.find(params[:id])
    @ogiri_odai.destroy
    redirect_to ogiri_odais_path
  end

  private

  def ogiri_odai_params
    params.require(:ogiri_odai).permit(:odai_image,  :genre_name, :ogiri_odai_select, :odai_text)
  end
  def ensure_correct_user
    @ogiri_odai = OgiriOdai.find(params[:id])
    unless @ogiri_odai.user == current_user
      redirect_to ogiri_odais_path
    end
  end

end
