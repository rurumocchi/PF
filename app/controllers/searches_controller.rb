class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.all
    @users = @users.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present? #ユーザ検索(部分検索)
    @search = params["search"]
  end

end