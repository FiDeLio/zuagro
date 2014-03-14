class AddAltitudeToItemsSites < ActiveRecord::Migration
  def change
    add_column :items_sites, :altitude, :float
  end
end
