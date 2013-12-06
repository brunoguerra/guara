class CreateGuaraGroups < ActiveRecord::Migration
  def change
    create_table :guara_groups do |t|
      t.string :name
      t.string :sumary
      t.references :parent
      t.references :module, :polymorphic => true

      t.timestamps
    end
    add_index :guara_groups, :parent_id
    add_index :guara_groups, :module_id
  end
end
