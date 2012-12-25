class CreateSystemAbilities < ActiveRecord::Migration
  def change
    create_table :system_abilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
