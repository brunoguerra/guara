class ChangeColumnEnableToEnabledScheduledClassifieds < ActiveRecord::Migration
  def up
    rename_column :guara_active_crm_scheduled_classifieds, :enable, :enabled
  end

  def down
  end
end
