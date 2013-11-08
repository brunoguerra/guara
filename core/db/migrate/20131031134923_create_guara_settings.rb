class CreateGuaraSettings < ActiveRecord::Migration
  def change
    create_table :guara_settings do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
