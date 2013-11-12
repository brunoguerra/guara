class CreateGuaraPlaces < ActiveRecord::Migration
  def change
    create_table :guara_places do |t|
      t.string :name
      t.boolean :enabled
      t.integer :external_id

      t.timestamps
    end
  end
end
