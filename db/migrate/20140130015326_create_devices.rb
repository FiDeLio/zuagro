class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :company, index: true
      t.string :unique_id
      t.references :user, index: true
      t.boolean :activated

      t.timestamps
    end
  end
end
