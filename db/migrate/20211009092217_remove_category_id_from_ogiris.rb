class RemoveCategoryIdFromOgiris < ActiveRecord::Migration[5.2]
  def change
    remove_column :ogiris, :image_id, :string
  end
end
