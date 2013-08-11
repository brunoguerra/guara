# This migration comes from guara (originally 20121228190807)
class CreateGuaraSystemExtensions < ActiveRecord::Migration
  def change
    create_table :guara_system_extensions do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
