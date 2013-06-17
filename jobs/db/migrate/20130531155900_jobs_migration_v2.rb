
class JobsMigrationV2 < ActiveRecord::Migration
  def change    
    #index
    add_index :guara_jobs_professionals, :have_job

    add_index :guara_jobs_process_instances, [:finished, :date_start]
    add_index :guara_jobs_process_instances, :date_finish
    add_index :guara_jobs_process_instances, :state


    add_index :guara_jobs_step_instances, :process_instance_id

    add_index :guara_jobs_step_instance_attrs, [:process_instance_id, :step_attr_id, :step_id], name: "guara_jobs_step_instances_pi_id_sa_id_s_id"

    add_index :guara_jobs_step_instance_attr_multis, :step_instance_attr_id, name: "index_guara_jobs_step_instance_attr_multis_st_inst_attr_id"

    add_index :guara_jobs_careers, :professional_experience_id

    add_index :guara_jobs_vacancy_scheduling_professionals, :vacancy_id, name: "index_guara_jobs_vacancy_scheduling_profs_vac_and_prof_id"
    add_index :guara_jobs_vacancy_scheduling_professionals, [:vacancy_id, :professional_id], name: "index_guara_jobs_vacancy_scheduling_profs_vac_id_prof_id"

    add_index :guara_jobs_vacancy_sended_professionals, :vacancy_scheduling_professional_id, name: "index_guara_jobs_vacancy_sended_profs_on_vac_sch_prof"

    add_index :guara_jobs_professional_languages, :professional_id 

    add_index :guara_jobs_vacancy_professionals_interviews, :vacancy_step_id, name: "index_guara_jobs_vac_profs_intws_on_vac_step_id"

    add_index :guara_jobs_vacancy_customer_interviews, :vacancy_sended_professionals_id, name: "index_guara_jobs_vacancy_cust_intws_on_vac_send_profs_id"
    add_index :guara_jobs_vacancy_customer_interviews, :vacancy_scheduling_professional_id, name: "index_guara_jobs_vacancy_customer_iws_vac_sch_prof_id"


    add_index :guara_jobs_vacancy_professionals_psychological_evaluations, :vacancy_customer_interview_id, name: "index_guara_jobs_vacancy_profs_psyc_int_id"
    add_index :guara_jobs_vacancy_professionals_psychological_evaluations, :vacancy_scheduling_professional_id, name: "index_guara_jobs_vacancy_profs_psyc_eval_vac_sch_prof"


    add_index :guara_jobs_vacancy_final_results, :vacancy_scheduling_professional_id, name: "index_guara_jobs_vacancy_final_res_vac_sched_prof"
    add_index :guara_jobs_vacancy_final_results, :vacancy_professionals_psychological_evaluation_id, name: "index_guara_jobs_vacancy_final_res_vac_profs_psyc_eval"

    add_index :guara_jobs_formations, :professional_id

    
    #
    add_column :guara_jobs_vacancies, :status_id, :integer, :default => 1    
    add_column :guara_jobs_step_attrs, :system_name, :string
    add_column :guara_jobs_vacancies, :customer_pj_id, :integer
    add_column :guara_jobs_vacancies, :role_id, :integer
    add_column :guara_jobs_vacancies, :type_id, :integer
    add_column :guara_jobs_vacancies, :total, :integer
    add_column :guara_jobs_vacancies, :salary_id, :integer
    add_column :guara_jobs_vacancies, :consultant_id, :integer

    
    
    
  end
end
