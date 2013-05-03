class JobsMigrationV2 < ActiveRecord::Migration
  def change    
    #index
    add_index :guara_jobs_professionals, :have_job

    add_index :guara_jobs_process_instances, [:finished, :date_start]
    add_index :guara_jobs_process_instances, :date_finish
    add_index :guara_jobs_process_instances, :state


    add_index :guara_jobs_step_instances, :process_instance_id

    add_index :guara_jobs_step_instance_attrs, [:process_instance_id, :step_attr_id, :step_id]

    add_index :guara_jobs_step_instance_attr_multis, :step_instance_attr_id

    add_index :guara_jobs_careers, :professional_experience_id

    add_index :guara_jobs_vacancy_scheduling_professionals, :vacancy_id
    add_index :guara_jobs_vacancy_scheduling_professionals, [:vacancy_id, :professional_id]

    add_index :guara_jobs_vacancy_sended_professionals, :vacancy_scheduling_professional

    add_index :guara_jobs_vacancy_sended_professionals, :vacancy_scheduling_professional

    add_index :guara_jobs_professional_languages, :professional_id

    add_index :guara_jobs_vacancy_professionals_interviews, :vacancy_step_id

    add_index :guara_jobs_vacancy_customer_interviews, :vacancy_sended_professionals_id
    add_index :guara_jobs_vacancy_customer_interviews, :vacancy_scheduling_professional_id
    add_index :guara_jobs_vacancy_customer_interviews, :vacancy_scheduling_professional_id


    add_index :guara_jobs_vacancy_professionals_psychological_evaluations, :vacancy_customer_interview_id
    add_index :guara_jobs_vacancy_professionals_psychological_evaluations, :vacancy_scheduling_professional_id


    add_index :guara_jobs_vacancy_final_results, :vacancy_scheduling_professional_id
    add_index :guara_jobs_vacancy_final_results, :vacancy_professionals_psychological_evaluation_id

    add_index :guara_jobs_formations, :professional_id

    
    #
    add_column :guara_jobs_vacancies, :status_id, :integer, :default => 1    
    add_column :guara_jobs_step_attr, :system_name
    add_column :guara_jobs_vacancies, :customer_id
    add_column :guara_jobs_vacancies, :role_id
    add_column :guara_jobs_vacancies, :type_id
    add_column :guara_jobs_vacancies, :total
    add_column :guara_jobs_vacancies, :salary_id
    add_column :guara_jobs_vacancies, :consultante_id
    
    
    
  end
end
