class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ogiris, dependent: :destroy
  has_many :ogiri_odais, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_ogiris, through: :favorites, source: :ogiri
  has_many :ogiri_comments, dependent: :destroy
  has_many :ogiri_answers, dependent: :destroy
  has_many :odai_favorites, dependent: :destroy
  has_many :favorited_ogiri_odais, through: :odai_favorites, source: :ogiri_odai
  has_many :answer_favorites, dependent: :destroy
  has_many :favorited_ogiri_answers, through: :answer_favorites, source: :ogiri_answer

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def favorited_by?(ogiri_id)
    favorites.where(ogiri_id: ogiri_id).exists?
  end

  def odai_favorited_by?(ogiri_odai_id)
    odai_favorites.where(ogiri_odai_id: ogiri_odai_id).exists?
  end

  def answer_favorited_by?(ogiri_answer_id)
    answer_favorites.where(ogiri_answer_id: ogiri_answer_id).exists?
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence: true
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }
  attachment :profile_image, destroy: false
end
