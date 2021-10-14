class Ogiri < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
	has_many :ogiri_comments, dependent: :destroy

  validates :answer, presence: true, length: { maximum: 200 }
  attachment :image

def favorited_by?(user)
	favorites.where(user_id: user.id).exists?
end

def Ogiri.ogiri_search(keyword)
    Ogiri.where("category LIKE?", "%#{keyword}%")
end

end
