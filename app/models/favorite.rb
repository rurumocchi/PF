class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :ogiri


  validates_uniqueness_of :ogiri_id, scope: :user_id
  validates_uniqueness_of :ogiri_odai_id, scope: :user_id
end
