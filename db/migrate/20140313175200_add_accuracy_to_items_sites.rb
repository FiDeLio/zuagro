class AddAccuracyToItemsSites < ActiveRecord::Migration
  def change
    add_column :items_sites, :accuracy, :float
  end
end
