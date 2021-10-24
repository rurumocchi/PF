class CreateAnswerFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_favorites do |t|
      t.integer :user_id
      t.integer :ogiri_answer_id

      t.timestamps
    end
  end
end
