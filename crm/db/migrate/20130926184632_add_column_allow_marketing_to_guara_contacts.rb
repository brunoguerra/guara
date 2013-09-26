class AddColumnAllowMarketingToGuaraContacts < ActiveRecord::Migration
  def change
    add_column :guara_contacts, :allow_marketing, :boolean, :default => true
  end
end
