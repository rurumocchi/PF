class CreateOdaiFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :odai_favorites do |t|
      t.integer :user_id
      t.integer :ogiri_odai_id

      t.timestamps
    end
  end
end
