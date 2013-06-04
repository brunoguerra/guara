# This migration comes from guara (originally 20120612000411)
class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
      add_column :guara_users, :remember_token, :string
      add_index  :guara_users, :remember_token
    end
end
