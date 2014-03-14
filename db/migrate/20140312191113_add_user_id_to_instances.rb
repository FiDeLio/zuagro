class AddUserIdToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :user_id, :integer
  end
end
