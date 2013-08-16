# This migration comes from guara (originally 20120723102847)
class CreateUserAbilities < ActiveRecord::Migration
  def change
    create_table :guara_user_abilities do |t|
      t.integer :module_id
      t.integer :ability_id
      t.references :skilled, :polymorphic => true
      t.timestamps
    end
  end
end
