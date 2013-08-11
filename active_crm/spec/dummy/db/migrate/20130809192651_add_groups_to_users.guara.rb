# This migration comes from guara (originally 20120729121922)
class AddGroupsToUsers < ActiveRecord::Migration
  def change
    add_column :guara_users, :primary_group_id, :integer
    add_index :guara_users, :primary_group_id
  end
end
