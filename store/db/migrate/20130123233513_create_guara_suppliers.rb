class CreateGuaraSuppliers < ActiveRecord::Migration
  def change
    create_table :guara_suppliers do |t|
      t.integer :person_id

      t.timestamps
    end
  end
end
