class CreateGuaraSystemPreferences < ActiveRecord::Migration
  def change
    create_table :guara_system_preferences do |t|
      t.string :property
      t.string :value
      t.string :default

      t.timestamps
    end
  end
end
