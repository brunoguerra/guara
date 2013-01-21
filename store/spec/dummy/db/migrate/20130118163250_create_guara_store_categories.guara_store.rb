# This migration comes from guara_store (originally 20130118140828)
class CreateGuaraStoreCategories < ActiveRecord::Migration
  def change
    create_table :guara_store_categories do |t|
      t.string :name
      t.integer :enabled
      t.integer :parent_id

      t.timestamps
    end
  end
end
