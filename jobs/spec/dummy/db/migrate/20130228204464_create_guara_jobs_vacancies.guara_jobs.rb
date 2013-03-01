# This migration comes from guara_jobs (originally 20130226182806)
class CreateGuaraJobsVacancies < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancies do |t|
      t.references :process_instance

      t.timestamps
    end
    add_index :guara_jobs_vacancies, :process_instance_id
  end
end
