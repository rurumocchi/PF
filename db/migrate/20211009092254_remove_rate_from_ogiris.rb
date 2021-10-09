class RemoveRateFromOgiris < ActiveRecord::Migration[5.2]
  def change
    remove_column :ogiris, :rate, :float
  end
end
