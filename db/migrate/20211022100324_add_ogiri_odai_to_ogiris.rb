class AddOgiriOdaiToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :ogiri_odai, :text
  end
end
