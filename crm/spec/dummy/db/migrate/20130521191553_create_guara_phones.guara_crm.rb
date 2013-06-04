# This migration comes from guara_crm (originally 20130521183024)
class CreateGuaraPhones < ActiveRecord::Migration
  def change
    create_table :guara_phones do |t|
      t.string :phone
      t.references :callable

      t.timestamps
    end
    add_index :guara_phones, :callable_id
  end
end
