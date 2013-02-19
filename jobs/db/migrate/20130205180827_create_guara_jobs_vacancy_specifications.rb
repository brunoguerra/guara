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
