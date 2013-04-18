class CreateGuaraJobsVacancyFinalResults < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_final_results do |t|
      t.integer :vacancy_scheduling_professional_id
      t.integer :vacancy_professionals_psychological_evaluation_id
      t.integer :result
      t.datetime :work_start_date
      t.string :salary
      t.string :observation

      t.timestamps
    end
  end
end
