class AddDealColumnToScheduledContacts < ActiveRecord::Migration
  def change
    add_column :guara_active_crm_scheduled_contacts, :deal_id, :integer
    add_column :guara_active_crm_scheduled_contacts, :user_id, :integer
  end
end
