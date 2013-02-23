class CreateGuaraJobsStepInstanceAttrs < ActiveRecord::Migration
  def change
    create_table :guara_jobs_step_instance_attrs do |t|
      t.integer :process_instance_id
      t.integer :step_attr_id
      t.integer :step_id
      t.string :value

      t.timestamps
    end
  end
end
