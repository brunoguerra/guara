class CreateGuaraScheduledContacts < ActiveRecord::Migration
  def change
    create_table :guara_scheduled_contacts do |t|
      t.references :contact
      t.text :activity
      t.integer :result
      t.references :classified
      t.datetime :scheduled

      t.timestamps
    end
    add_index :guara_scheduled_contacts, :contact_id
    add_index :guara_scheduled_contacts, :classified_id
  end
end
