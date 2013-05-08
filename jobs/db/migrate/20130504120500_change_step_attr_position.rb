
class ChangeStepAttrPosition < ActiveRecord::Migration
  def change    
    #index
    add_column :guara_jobs_step_attrs, :position_ok, :integer, :default => 0

    Guara::Jobs::StepAttr.update_all('position_ok=position::int')

    remove_column :guara_jobs_step_attrs, :position
    rename_column :guara_jobs_step_attrs, :position_ok, :position
  end
end
