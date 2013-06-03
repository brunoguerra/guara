# This migration comes from guara (originally 20120729112600)
class CreateUsersHasGroups < ActiveRecord::Migration
  def change
    create_table :guara_users_has_groups do |t|
      t.integer :user_id
      t.integer :user_group_id

      t.timestamps
    end
    
    add_index :guara_users_has_groups, :user_id
    add_index :guara_users_has_groups, :user_group_id
    add_index :guara_users_has_groups, [:user_id, :user_group_id], unique: true    
  end
end
