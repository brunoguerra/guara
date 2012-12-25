class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name, :limit => 60
      t.references :city
      t.timestamps
    end
    
    add_index :districts, :city_id
  end
end
