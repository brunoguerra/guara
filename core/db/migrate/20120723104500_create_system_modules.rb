class CreateSystemModules < ActiveRecord::Migration
  def change
    create_table :system_modules do |t|
      t.string :name

      t.timestamps
    end
  end
end
