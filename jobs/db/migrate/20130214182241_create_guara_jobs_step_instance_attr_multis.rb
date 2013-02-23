class CreateGuaraJobsStepInstanceAttrMultis < ActiveRecord::Migration
  def change
    create_table :guara_jobs_step_instance_attr_multis do |t|
      t.string :step_instance_attr_id
      t.string :value

      t.timestamps
    end
  end
end
