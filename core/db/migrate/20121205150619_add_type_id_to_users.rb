class AddTypeIdToUsers < ActiveRecord::Migration
  def change
    add_column :guara_users, :type_id, :integer, :null => false, :default => 0
  end
end
