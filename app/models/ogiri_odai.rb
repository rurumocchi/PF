class OgiriOdai < ApplicationRecord

  belongs_to :user
  has_many :ogiri_answers, dependent: :destroy
  has_many :odai_favorites, dependent: :destroy
  has_many :favorited_users, through: :odai_favorites, source: :user
  has_many :answer_favorites, dependent: :destroy
  has_many :favorited_users, through: :answer_favorites, source: :user

   attachment :odai_image
   enum ogiri_odai_select: { select_image: 0, select_ogiri: 1}

  def odai_favorited_by?(user)
	odai_favorites.where(user_id: user.id).exists?
  end


  def OgiriOdai.search_genre(keyword)
    OgiriOdai.where("genre_name LIKE?", "%#{keyword}%")
  end
end
