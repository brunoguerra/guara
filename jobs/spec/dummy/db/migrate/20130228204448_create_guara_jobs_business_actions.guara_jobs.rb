# This migration comes from guara_jobs (originally 20130205181339)
class CreateGuaraJobsBusinessActions < ActiveRecord::Migration
  def change
    create_table :guara_jobs_business_actions do |t|
      t.string :name

      t.timestamps
    end
  end
end
