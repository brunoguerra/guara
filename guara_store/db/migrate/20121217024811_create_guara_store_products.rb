class CreateGuaraStoreProducts < ActiveRecord::Migration
  def change
    create_table :guara_store_products do |t|
      t.string :name

      t.timestamps
    end
  end
end
