class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :guara_users, :email, unique: true
  end
end
