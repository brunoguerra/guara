# This migration comes from guara_jobs (originally 20130222190158)
class CreateGuaraJobsConsultants < ActiveRecord::Migration
  def change
    create_table :guara_jobs_consultants do |t|
      t.string :name
      t.boolean :enable

      t.timestamps
    end
  end
end
