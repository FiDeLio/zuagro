class CreateItemsSites < ActiveRecord::Migration
  def change
    create_table :items_sites do |t|
      t.references :site, index: true
      t.float :lat
      t.float :lng
      t.float :speed
      t.datetime :ts

      t.timestamps
    end
  end
end
