class CreateGuaraJobsVacancySendedProfessionals < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_sended_professionals do |t|
      t.references :vacancy_scheduling_professional
      t.datetime :date
      t.integer :step_instance_id

      t.timestamps
    end
    add_index :guara_jobs_vacancy_sended_professionals, :vacancy_scheduling_professional_id, :name=> "guara_jobs_vacancy_sch_profs_send"
  end
end
