# This migration comes from guara_jobs (originally 20130205181618)
class CreateGuaraJobsRoles < ActiveRecord::Migration
  def change
    create_table :guara_jobs_roles do |t|
      t.string :name
      t.integer :business_action_id

      t.timestamps
    end
  end
end
