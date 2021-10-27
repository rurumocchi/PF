class OgiriAnswer < ApplicationRecord

  belongs_to :user
  belongs_to :ogiri_odai
  has_many :answer_favorites, dependent: :destroy
  has_many :favorited_users, through: :answer_favorites, source: :user

  def answer_favorited_by?(user)
	  answer_favorites.where(user_id: user.id).exists?
  end

  validates :ogiri_answer, presence: true, length: { maximum: 100 }
end
