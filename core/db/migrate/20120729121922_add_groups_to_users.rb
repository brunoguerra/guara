class AddGroupsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_group_id, :integer
    add_index :users, :primary_group_id
  end
end
