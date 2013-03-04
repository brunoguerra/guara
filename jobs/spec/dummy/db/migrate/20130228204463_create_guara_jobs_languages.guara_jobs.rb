# This migration comes from guara_jobs (originally 20130226154948)
class CreateGuaraJobsLanguages < ActiveRecord::Migration
  def change
    create_table :guara_jobs_languages do |t|
      t.string :name
      t.references :professional

      t.timestamps
    end
  end
end
