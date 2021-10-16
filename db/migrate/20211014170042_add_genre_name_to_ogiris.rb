class AddGenreNameToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :genre_name, :string
  end
end
