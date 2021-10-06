class Category < ApplicationRecord

  has_many :ogiris

  validates :category, presence: true
end
