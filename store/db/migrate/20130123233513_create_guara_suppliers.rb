class CreateGuaraSuppliers < ActiveRecord::Migration
  def change
    create_table :guara_suppliers do |t|
      t.integer :customer_pj_id

      t.timestamps
    end
  end
end
