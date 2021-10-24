class OgiriAnswer < ApplicationRecord

  belongs_to :user
  belongs_to :ogiri_odai

  validates :ogiri_answer, presence: true, length: { maximum: 200 }
end
