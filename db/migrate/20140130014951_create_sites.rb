class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :company, index: true
      t.string :name
      t.boolean :activated

      t.timestamps
    end
  end
end
