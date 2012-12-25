class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name, :limit => 60
      t.integer :state_id
      t.timestamps
    end
    
    add_index :cities, :state_id
  end
end
