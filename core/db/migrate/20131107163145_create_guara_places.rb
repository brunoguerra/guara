class CreateGuaraPlaces < ActiveRecord::Migration
  def change
    create_table :guara_places do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
