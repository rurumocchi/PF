class Ogiri < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
	has_many :ogiri_comments, dependent: :destroy

  validates :answer, presence: true, length: { maximum: 200 }
  validates :ogiri_odai, length: { maximum: 75 }
  attachment :image

  enum ogiri_select: { select_image: 0, select_ogiri: 1}

def favorited_by?(user)
	favorites.where(user_id: user.id).exists?
end

def Ogiri.search_genre(keyword)
    Ogiri.where("genre_name LIKE?", "%#{keyword}%")
end

end
