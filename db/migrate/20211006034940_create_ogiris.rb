class CreateOgiris < ActiveRecord::Migration[5.2]
  def change
    create_table :ogiris do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :image_id
      t.text :answer
      t.float :rate

      t.timestamps
    end
  end
end
