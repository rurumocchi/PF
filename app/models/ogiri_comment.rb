class OgiriComment < ApplicationRecord

  belongs_to :user
  belongs_to :ogiri

  validates :comment, presence: true
  validates :rate, presence: true, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }

end
