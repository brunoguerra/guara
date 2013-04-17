class AddColumnSynthesisToVacancyProfessionalsInterview < ActiveRecord::Migration
  def change
    add_column :guara_jobs_vacancy_professionals_interviews, :synthesis, :text
  end
end
