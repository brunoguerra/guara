# This migration comes from guara_jobs (originally 20130205180827)
class CreateGuaraJobsVacancySpecifications < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_specifications do |t|
      t.decimal :salary_requirements, :precision => 10, :scale => 2, :default => 0
      t.references :role
      t.references :professional

      t.timestamps
    end
  end
end
