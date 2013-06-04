# This migration comes from guara (originally 20120610185217)
class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    #add_column :users, :password_digest, :string
  end
end
