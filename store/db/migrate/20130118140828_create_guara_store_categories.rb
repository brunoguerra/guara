class CreateGuaraStoreCategories < ActiveRecord::Migration
  def change
    create_table :guara_store_categories do |t|
      t.string :name
      t.boolean :enabled
      t.integer :parent_id

      t.timestamps
    end
  end
end
