# This migration comes from guara (originally 20120610183820)
class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :guara_users, :email, unique: true
  end
end
