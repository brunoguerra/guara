class CreateUserAbilities < ActiveRecord::Migration
  def change
    create_table :user_abilities do |t|
      t.integer :module_id
      t.integer :ability_id
      t.references :skilled, :polymorphic => true
      t.timestamps
    end
  end
end
