class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.references :company, index: true
      t.text :json
      t.float :version
      t.references :device, index: true

      t.timestamps
    end
  end
end
