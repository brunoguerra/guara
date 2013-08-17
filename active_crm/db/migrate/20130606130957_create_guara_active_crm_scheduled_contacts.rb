class CreateGuaraActiveCrmScheduledContacts < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_contacts do |t|
      t.references :contact
      t.references :person
      t.text :activity
      t.integer :result
      t.references :classified
      t.datetime :scheduled_at
      t.integer :scheduled_id
      t.boolean :enabled, default: true

      t.timestamps
    end
    
    add_index :guara_active_crm_scheduled_contacts, :contact_id
    add_index :guara_active_crm_scheduled_contacts, :person_id
    add_index :guara_active_crm_scheduled_contacts, :classified_id
    add_index :guara_active_crm_scheduled_contacts, :scheduled_id
    add_index :guara_active_crm_scheduled_contacts, :scheduled_at
  end
end
