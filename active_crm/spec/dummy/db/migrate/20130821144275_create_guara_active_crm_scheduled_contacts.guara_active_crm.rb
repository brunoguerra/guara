# This migration comes from guara_active_crm (originally 20130606130957)
class CreateGuaraActiveCrmScheduledContacts < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_contacts do |t|
      t.references :deal, null: false
      t.references :user, null: false
      t.references :contact
      t.references :classified
      t.text :activity, null: false
      t.integer :result, null: false
      t.datetime :scheduled_at

      t.boolean :enabled, default: true

      t.timestamps
    end
    
    add_index :guara_active_crm_scheduled_contacts, :contact_id
    add_index :guara_active_crm_scheduled_contacts, :deal_id
    add_index :guara_active_crm_scheduled_contacts, :classified_id
    add_index :guara_active_crm_scheduled_contacts, :scheduled_at
  end
end
