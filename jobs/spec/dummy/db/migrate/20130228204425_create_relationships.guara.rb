# This migration comes from guara (originally 20120617224530)
class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :guara_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :guara_relationships, :follower_id
    add_index :guara_relationships, :followed_id
    add_index :guara_relationships, [:follower_id, :followed_id], unique: true
  end
end