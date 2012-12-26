class CreateSystemAbilities < ActiveRecord::Migration
  def change
    create_table :guara_system_abilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
