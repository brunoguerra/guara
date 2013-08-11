# This migration comes from guara_active_crm (originally 20130611135918)
class AddDealColumnToScheduledContacts < ActiveRecord::Migration
  def change
    add_column :guara_active_crm_scheduled_contacts, :deal_id, :integer
    add_column :guara_active_crm_scheduled_contacts, :user_id, :integer
  end
end
