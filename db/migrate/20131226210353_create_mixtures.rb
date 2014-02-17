class CreateMixtures < ActiveRecord::Migration
  def change
    create_table :mixtures do |t|
      t.string :name
      t.float :n
      t.float :p2o5
      t.float :k20
      t.float :cao
      t.float :s
      t.float :mgo
      t.float :b
      t.timestamps
    end
  end
end
