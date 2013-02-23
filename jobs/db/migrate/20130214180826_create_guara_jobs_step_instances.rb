class CreateGuaraJobsStepInstances < ActiveRecord::Migration
  def change
    create_table :guara_jobs_step_instances do |t|
      t.integer :process_instance_id
      t.timestamps
    end
  end
end
