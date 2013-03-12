# This migration comes from guara_jobs (originally 20130312133331)
class CreateGuaraJobsVacancyProfessionalsInterviews < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_professionals_interviews do |t|
      t.integer :scheduling_id
      t.datetime :date
      t.integer :vacancy_step_id
      t.integer :interview_process_instance_id

      t.timestamps
    end
    add_index :guara_jobs_vacancy_professionals_interviews, :scheduling_id, name: "vacancy_schd_id"
  end
end
