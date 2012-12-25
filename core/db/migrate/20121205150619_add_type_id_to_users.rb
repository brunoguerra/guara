class AddTypeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type_id, :integer, :null => false, :default => 0
  end
end
