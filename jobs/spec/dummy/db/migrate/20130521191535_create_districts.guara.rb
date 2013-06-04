# This migration comes from guara (originally 20120621100705)
class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :guara_districts do |t|
      t.string :name, :limit => 60
      t.references :city
      t.timestamps
    end
    
    add_index :guara_districts, :city_id
  end
end
