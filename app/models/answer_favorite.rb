class AnswerFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :ogiri_answer

  validates_uniqueness_of :ogiri_answer_id, scope: :user_id
end
