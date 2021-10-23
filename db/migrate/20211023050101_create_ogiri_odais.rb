class CreateOgiriOdais < ActiveRecord::Migration[5.2]
  def change
    create_table :ogiri_odais do |t|

      t.integer :user_id
      t.string :odai_image_id
      t.integer :ogiri_odai_select, default: 0
      t.text :odai_text
      t.string :genre_name
      t.float :rate

      t.timestamps
    end
  end
end
