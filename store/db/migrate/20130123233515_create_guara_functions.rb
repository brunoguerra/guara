class CreateGuaraFunctions < ActiveRecord::Migration
  def change
    create_table :guara_functions do |t|
      t.string :field
      t.integer :role
      t.float :salary_requirements

      t.timestamps
    end
  end
end
