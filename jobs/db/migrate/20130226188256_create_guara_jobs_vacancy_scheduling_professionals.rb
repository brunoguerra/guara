class CreateGuaraJobsVacancySchedulingProfessionals < ActiveRecord::Migration
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
    add_index :guara_jobs_vacancy_scheduling_professionals, :vacancy_id, :name=> "guara_jobs_vacancy_sch_profs"
  end
end
