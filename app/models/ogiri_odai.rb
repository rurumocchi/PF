class OgiriOdai < ApplicationRecord

  belongs_to :user
  has_many :ogiri_answers, dependent: :destroy

   attachment :odai_image
   enum ogiri_odai_select: { select_image: 0, select_ogiri: 1}

  def OgiriOdai.search_genre(keyword)
    OgiriOdai.where("genre_name LIKE?", "%#{keyword}%")
  end
end
