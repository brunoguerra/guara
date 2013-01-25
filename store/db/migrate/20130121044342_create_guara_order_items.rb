class CreateGuaraOrderItems < ActiveRecord::Migration
  def change
    create_table :guara_order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :total
      t.float :price

      t.timestamps
    end
    
    add_index :guara_order_items, :order_id
    add_index :guara_order_items, :product_id
  end
end
