# This migration comes from guara_jobs (originally 20130214180826)
class CreateGuaraJobsStepInstances < ActiveRecord::Migration
  def change
    create_table :guara_jobs_step_instances do |t|
      t.integer :process_instance_id
      t.timestamps
    end
  end
end
