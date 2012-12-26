class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :guara_users, :admin, :boolean, default: false
  end
end
