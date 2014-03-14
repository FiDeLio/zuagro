class AddCommentsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :comments, :text
  end
end
