class OdaiFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :ogiri_odai

  validates_uniqueness_of :ogiri_odai_id, scope: :user_id
end
