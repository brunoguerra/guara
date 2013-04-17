class AddColumnNumberToGuaraPeople < ActiveRecord::Migration
  def change
    add_column :guara_people, :number, :string
  end
end
