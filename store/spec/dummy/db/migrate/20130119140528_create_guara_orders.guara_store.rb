# This migration comes from guara_store (originally 20130119135649)
class CreateGuaraOrders < ActiveRecord::Migration
  def change
    create_table :guara_orders do |t|
      t.integer :person_id
      t.integer :type
      t.integer :state
      t.datetime :date_init
      t.datetime :date_finish
      t.date :state_date
      t.integer :payment_type
      t.datetime :payment_date
      t.integer :payment_state

      t.timestamps
    end
    
    add_index :guara_orders, :state
    add_index :guara_orders, :type
    add_index :guara_orders, [:state, :type]
  end
end
