# This migration comes from guara (originally 20120621100720)
class CreateCities < ActiveRecord::Migration
  def change
    create_table :guara_cities do |t|
      t.string :name, :limit => 60
      t.integer :state_id
      t.timestamps
    end
    
    add_index :guara_cities, :state_id
  end
end
