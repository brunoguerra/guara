# This migration comes from guara (originally 20120723104500)
class CreateSystemModules < ActiveRecord::Migration
  def change
    create_table :guara_system_modules do |t|
      t.string :name

      t.timestamps
    end
  end
end
