class OgiriOdai < ApplicationRecord

  belongs_to :user
  has_many :ogiri_answers, dependent: :destroy
  has_many :odai_favorites, dependent: :destroy
  has_many :favorited_users, through: :odai_favorites, source: :user

   attachment :odai_image
   # お題投稿ラジオボタン
   enum ogiri_odai_select: { select_image: 0, select_ogiri: 1}

  def odai_favorited_by?(user)
	  odai_favorites.where(user_id: user.id).exists?
  end

  # 検索用のメソッド定義(部分一致のみ)
  def OgiriOdai.search_genre_odai(keyword)
    OgiriOdai.where("genre_name LIKE?", "%#{keyword}%")
  end
end
