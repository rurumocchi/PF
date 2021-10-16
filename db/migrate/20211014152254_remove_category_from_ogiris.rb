class RemoveCategoryFromOgiris < ActiveRecord::Migration[5.2]
  def change
    remove_column :ogiris, :category, :string
  end
end
