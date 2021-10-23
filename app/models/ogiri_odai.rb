class OgiriOdai < ApplicationRecord

  belongs_to :user

   validates :odai_text, presence: true, length: { maximum: 200 }
   attachment :odai_image
   enum ogiri_odai_select: { select_image: 0, select_ogiri: 1}
end
