class AddOgiriSelectToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :ogiri_select, :integer, default: 0
  end
end
