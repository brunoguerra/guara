# This migration comes from guara (originally 20120728181903)
class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :guara_user_groups do |t|
      t.string :name
      t.boolean :enabled,  :default => true
      t.boolean :system,   :default => false
      t.timestamps
    end
  end
end
