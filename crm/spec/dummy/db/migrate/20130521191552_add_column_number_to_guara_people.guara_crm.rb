# This migration comes from guara_crm (originally 20130417111454)
class AddColumnNumberToGuaraPeople < ActiveRecord::Migration
  def change
    add_column :guara_people, :number, :string
  end
end
