class AddSalaryRequerimentIdToGuaraJobsVacancySpecifications < ActiveRecord::Migration
  def change
    add_column :guara_jobs_vacancy_specifications, :salary_requirement_id, :integer
    remove_column :guara_jobs_vacancy_specifications, :salary_requirements

  end
end
