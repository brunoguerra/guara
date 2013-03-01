# This migration comes from guara (originally 20120616215835)
class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :guara_microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :guara_microposts, [:user_id, :created_at]
  end
end