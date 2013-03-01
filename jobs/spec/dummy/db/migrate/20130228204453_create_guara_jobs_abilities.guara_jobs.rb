# This migration comes from guara_jobs (originally 20130205183708)
class CreateGuaraJobsAbilities < ActiveRecord::Migration
  def change
    create_table :guara_jobs_abilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
