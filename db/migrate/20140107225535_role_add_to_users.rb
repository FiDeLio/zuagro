class RoleAddToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, :defauls => 1
  end
end
