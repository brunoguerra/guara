class CreateGuaraCurrencies < ActiveRecord::Migration
  def change
    create_table :guara_currencies do |t|
      t.string :code
      t.string :symbol
      t.string :description

      t.timestamps
    end
  end
end
