class CreateGuaraJobsVacancySchedulersProfessionals < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_scheduling_professionals do |t|
      
      t.timestamps :date_time
      t.string :local
      t.string :description
      t.references :consultant
      t.references :professional
      t.references :vancacy      

      t.timestamps 
    end
    add_index :guara_jobs_vacancy_scheduleing_professionals, :vancacy_id
  end
end
