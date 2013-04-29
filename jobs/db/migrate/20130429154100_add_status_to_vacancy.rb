class AddStatusToVacancy < ActiveRecord::Migration
  def change
    add_column :guara_jobs_vacancies, :status_id, :integer, :default => 1
  end
end
