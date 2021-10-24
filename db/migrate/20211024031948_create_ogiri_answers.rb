class CreateOgiriAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :ogiri_answers do |t|
      t.integer :user_id
      t.integer :ogiri_odai_id
      t.string :ogiri_answer

      t.timestamps
    end
  end
end
