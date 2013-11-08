class CreateGuaraGeos < ActiveRecord::Migration
  def change
    create_table :guara_geos do |t|
      t.references :thing, :polymorphic => true
      t.decimal :lat, :precision => 9, :scale => 6
      t.decimal :long, :precision => 9, :scale => 6

      t.timestamps
    end
    add_index :guara_geos, :thing_id
  end
end
