class CreateGuaraJobsVacancyProfessionalsPsychologicalEvaluations < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_professionals_psychological_evaluations do |t|
      t.datetime :date_evaluation
      t.string :path_documents
      t.datetime :date_send_report
      t.integer :vacancy_customer_interview_id
      t.integer :vacancy_scheduling_professional_id

      t.timestamps
    end
  end
end
