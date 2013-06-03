# This migration comes from guara (originally 20120723104639)
class CreateSystemAbilities < ActiveRecord::Migration
  def change
    create_table :guara_system_abilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
