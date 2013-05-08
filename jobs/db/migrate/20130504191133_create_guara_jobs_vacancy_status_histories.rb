class CreateGuaraJobsVacancyStatusHistories < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_status_histories do |t|
      t.references :user
      t.integer :status_old
      t.integer :status_new
      t.references :vacancy

      t.timestamps
    end
    add_index :guara_jobs_vacancy_status_histories, :user_id
    add_index :guara_jobs_vacancy_status_histories, :vacancy_id
  end
end
