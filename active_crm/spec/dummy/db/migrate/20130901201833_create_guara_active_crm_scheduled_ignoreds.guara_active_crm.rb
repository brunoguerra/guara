# This migration comes from guara_active_crm (originally 20130901201141)
class CreateGuaraActiveCrmScheduledIgnoreds < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_ignoreds do |t|
      t.integer :customer_id
      t.integer :group_id

      t.timestamps
    end
  end
end
