# This migration comes from guara_active_crm (originally 20130606124513)
class CreateGuaraActiveCrmScheduledGroups < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_groups do |t|
      t.string :business_activities
      t.string :business_segments
      t.integer :employes_min
      t.integer :employes_max
      t.string :name_contains
      t.string :district_contains
      t.string :doc_equals
      t.string :pair_or_odd, limit: 1
      t.integer :finished_id
      t.integer :scheduled_id

      t.timestamps
    end
  end
end
