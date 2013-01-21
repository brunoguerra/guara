# This migration comes from guara (originally 20120616162515)
class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :guara_users, :admin, :boolean, default: false
  end
end
