class CreateGuaraProductCategories < ActiveRecord::Migration
  def change
    create_table :guara_product_categories do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end
end
