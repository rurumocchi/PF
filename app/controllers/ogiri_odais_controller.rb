class OgiriOdaisController < ApplicationController

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
    @ogiri_odais = OgiriOdai.all
  end

  def show
  end

  def destroy
  end

  private

  def ogiri_odai_params
    params.require(:ogiri_odai).permit(:odai_image,  :genre_name, :ogiri_odai_select, :odai_text, :rate)
  end
  def ensure_correct_user
    @ogiri_odai = OgiriOdai.find(params[:id])
    unless @ogiri_odai.user == current_user
      redirect_to ogiri_odais_path
    end
  end

end
