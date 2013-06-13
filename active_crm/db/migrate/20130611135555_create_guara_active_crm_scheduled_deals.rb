class CreateGuaraActiveCrmScheduledDeals < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_deals do |t|
      t.references :scheduled
      t.references :customer_pj
      t.datetime :date_start
      t.datetime :date_finish
      t.references :groups
      t.boolean :closed, default: false

      t.timestamps
    end
    add_index :guara_active_crm_scheduled_deals, :scheduled_id
    add_index :guara_active_crm_scheduled_deals, :customer_pj_id
  end
end
