# This migration comes from guara_active_crm (originally 20130903213338)
class ChangeFinishedIdScheduledGroups < ActiveRecord::Migration
  def up
    remove_column :guara_active_crm_scheduled_groups, :finished_id
    add_column :guara_active_crm_scheduled_groups, :finished_id, :string
  end

  def down
    remove_column :guara_active_crm_scheduled_groups, :finished_id
    add_column :guara_active_crm_scheduled_groups, :finished_id, :integer
  end
end
