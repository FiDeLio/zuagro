class CreateFertilizers < ActiveRecord::Migration
  def change
    create_table :fertilizers do |t|
      t.string :name
      t.float :n_total
      t.float :n_nh4
      t.float :n_no3
      t.float :p2o5
      t.float :k20
      t.float :cao
      t.float :s
      t.float :mgo
      t.float :b
      t.float :zn
      t.float :na
      t.timestamps
    end
  end
end
