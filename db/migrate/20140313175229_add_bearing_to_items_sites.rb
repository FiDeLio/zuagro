class AddBearingToItemsSites < ActiveRecord::Migration
  def change
    add_column :items_sites, :bearing, :float
  end
end
