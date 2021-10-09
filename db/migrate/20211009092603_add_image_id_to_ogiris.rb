class AddImageIdToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :image_id, :string
  end
end
