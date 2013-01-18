# This migration comes from guara (originally 20121104141751)
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :guara_addresses do |t|
      t.integer :country_id
      t.integer :state_id
      t.integer :city_id
      t.integer :district_id
      t.string :address, :limit => 120
      t.string :complement, :limit => 30
      t.string :postal_code, :limit => 20
      
      t.references :addressable, :polymorphic => true

      t.timestamps
    end
    
    add_index :guara_addresses, [:state_id, :city_id]
  end
end
