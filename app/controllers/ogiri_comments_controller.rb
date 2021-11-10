class OgiriCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ogiri = Ogiri.find(params[:ogiri_id])
    @ogiri_comment = OgiriComment.new(ogiri_comment_params)
    @ogiri_comment.ogiri_id = @ogiri.id
    @ogiri_comment.user_id = current_user.id
    if @ogiri_comment.save!
      redirect_to ogiri_path(@ogiri.id)
    else
      render 'ogiris/show'
    end
  end

  def destroy
    @ogiri = Ogiri.find(params[:ogiri_id])
    ogiri_comment = @ogiri.ogiri_comments.find(params[:id])
    ogiri_comment.destroy
    redirect_to request.referer
  end

  private

  def ogiri_comment_params
    params.require(:ogiri_comment).permit(:comment, :rate)
  end
end
