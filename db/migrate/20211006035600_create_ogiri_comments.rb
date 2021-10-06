class CreateOgiriComments < ActiveRecord::Migration[5.2]
  def change
    create_table :ogiri_comments do |t|
      t.integer :user_id
      t.integer :ogiri_id
      t.text :comment
      t.float :rate

      t.timestamps
    end
  end
end
