class OgiriAnswersController < ApplicationController
before_action :authenticate_user!

  def new
    @ogiri_odai = OgiriOdai.find(params[:ogiri_odai_id]) #回答するお題
    @ogiri_answer = OgiriAnswer.new
  end
  def create
    @ogiri_odai = OgiriOdai.find(params[:ogiri_odai_id])
    @ogiri_answer = OgiriAnswer.new(ogiri_answer_params)
    @ogiri_answer.ogiri_odai_id = @ogiri_odai.id
    @ogiri_answer.user_id = current_user.id
    if @ogiri_answer.save!
  	  redirect_to ogiri_odai_path(@ogiri_odai.id)
    else
		  render 'ogiri_odais/show'
    end
  end

  def show
    
     @ogiri_answer = OgiriAnswer.find(params[:ogiri_odai_id]) #お題に対してした回答の詳細
  end

  def answer_favorite_rank
    @ogiri_answers = OgiriAnswer.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def destroy
    @ogiri_odai = OgiriOdai.find(params[:ogiri_odai_id])
    ogiri_answer = @ogiri_odai.ogiri_answers.find(params[:id])
		ogiri_answer.destroy
		redirect_to request.referer
  end

  private

  def ogiri_answer_params
		params.require(:ogiri_answer).permit(:ogiri_answer, :ogiri_odai_id)
	end

	def ensure_correct_user
    @ogiri_answer = OgiriAnswer.find(params[:ogiri_odai_id])
    unless @ogiri_answer.user == current_user
      redirect_to ogiri_odais_path
    end
  end

end
