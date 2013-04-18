class CreateGuaraJobsVacancyCustomerInterviews < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_customer_interviews do |t|
      t.integer :vacancy_sended_professionals_id
      t.integer :vacancy_scheduling_professional_id
      t.datetime :return_date
      t.integer :return_interview
      t.string :motive

      t.timestamps
    end
  end
end
