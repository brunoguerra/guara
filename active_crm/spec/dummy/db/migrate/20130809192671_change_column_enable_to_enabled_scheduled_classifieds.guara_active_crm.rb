# This migration comes from guara_active_crm (originally 20130719142032)
class ChangeColumnEnableToEnabledScheduledClassifieds < ActiveRecord::Migration
  def up
    rename_column :guara_active_crm_scheduled_classifieds, :enable, :enabled
  end

  def down
  end
end
