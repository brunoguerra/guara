# This migration comes from guara_jobs (originally 20130214180519)
class CreateGuaraJobsProcessInstances < ActiveRecord::Migration
  def change
    create_table :guara_jobs_process_instances do |t|
      t.integer :process_id
      t.date :date_start
      t.date :date_finish
      t.integer :user_using_process
      t.integer :state

      t.timestamps
    end
  end
end
