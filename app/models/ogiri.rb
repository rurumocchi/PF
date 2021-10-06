class Ogiri < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy
	has_many :ogiri_comments, dependent: :destroy

  validates :answer, presence: true, length: { maximum: 200 }
  attachment :image, destroy: false
  validates :rate, presence: true, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }

def favorited_by?(user)
	favorites.where(user_id: user.id).exists?
end

end
