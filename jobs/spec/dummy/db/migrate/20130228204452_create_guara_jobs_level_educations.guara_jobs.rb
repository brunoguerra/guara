# This migration comes from guara_jobs (originally 20130205182737)
class CreateGuaraJobsLevelEducations < ActiveRecord::Migration
  def change
    create_table :guara_jobs_level_educations do |t|
      t.string :name

      t.timestamps
    end
  end
end
