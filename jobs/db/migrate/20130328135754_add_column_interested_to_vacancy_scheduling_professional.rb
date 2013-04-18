class AddColumnInterestedToVacancySchedulingProfessional < ActiveRecord::Migration
  def change
    add_column :guara_jobs_vacancy_scheduling_professionals, :interested, :boolean

  end
end
