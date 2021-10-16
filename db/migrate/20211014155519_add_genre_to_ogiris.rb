class AddGenreToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :genre, :integer
  end
end
