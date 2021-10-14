class AddCategoryToOgiris < ActiveRecord::Migration[5.2]
  def change
    add_column :ogiris, :category, :string
  end
end
