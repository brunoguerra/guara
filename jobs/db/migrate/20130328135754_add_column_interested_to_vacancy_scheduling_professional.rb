class AddColumnInterestedToVacancySchedulingProfessional < ActiveRecord::Migration
  def change
    add_column :guara_jobs_vacancy_scheduling_professionals, :interested, :boolean
    remove_column :guara_jobs_vacancy_scheduling_professionals, :retrospect_professional
    remove_column :guara_jobs_vacancy_scheduling_professionals, :prospective_plans
  end
end
