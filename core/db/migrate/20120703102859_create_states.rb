class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, :limit => 30
      t.string :acronym, :limit => 2
      
      t.timestamps
    end
  end
end
