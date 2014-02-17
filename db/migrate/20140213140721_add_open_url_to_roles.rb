class AddOpenUrlToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :open_path, :string
  end
end
