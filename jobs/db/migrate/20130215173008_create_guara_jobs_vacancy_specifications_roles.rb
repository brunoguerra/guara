class CreateGuaraJobsVacancySpecificationsRoles < ActiveRecord::Migration
  def change
    create_table :guara_jobs_vacancy_specifications_roles do |t|
      t.references :role
      t.references :vacancy_specification

      t.timestamps
    end
    add_index :guara_jobs_vacancy_specifications_roles, :role_id, :name => "guara_jobs_vacancy_spec_roles_id"
    add_index :guara_jobs_vacancy_specifications_roles, :vacancy_specification_id, :name => "guara_jobs_vacancy_spec_id"
  end
end
