class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :sequence
      t.string :name
      t.references :role, index: true

      t.timestamps
    end
  end
end
