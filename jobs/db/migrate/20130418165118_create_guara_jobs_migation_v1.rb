class CreateGuaraJobsMigationV1 < ActiveRecord::Migration
  def change
  	create_table  :guara_jobs_custom_processes do |t|
  		t.string  :name
  		t.string  :hook_instanciate
  		t.integer :business_id
  		t.integer :step_init
  		t.boolean :enabled

    		t.timestamps
  	end
  	
    create_table :guara_jobs_steps do |t|
      t.string 	 :name
      t.integer  :next
      t.integer  :level
      t.integer  :custom_process_id

      t.timestamps
    end
    
    create_table :guara_jobs_step_attrs do |t|
      t.string   :title
      t.integer  :position
      t.string   :options
      t.string   :widget
      t.string   :group
      t.string   :type_field
      t.boolean  :resume
      t.boolean  :required
      t.integer  :column
      t.integer  :step_id
      
      t.timestamps
    end
    
    create_table :guara_jobs_vacancy_specifications do |t|
      t.decimal :salary_requirements, :precision => 10, :scale => 2, :default => 0
      t.references :role
      t.references :professional

      t.timestamps
    end
    
    create_table :guara_jobs_business_actions do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :guara_jobs_roles do |t|
      t.string :name
      t.integer :business_action_id

      t.timestamps
    end
    
    create_table :guara_jobs_professional_experiences do |t|
      
      t.string :company_name
      t.references :professional

      t.timestamps
    end
    
    create_table :guara_jobs_formations do |t|
      t.references :level_education
      t.string :course
      t.string :situation
      t.text :description
      t.string :name_institution
      t.date :date_conclusion
      t.references :professional

      t.timestamps
    end
    
    create_table :guara_jobs_level_educations do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :guara_jobs_abilities do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :guara_jobs_professionals do |t|
      t.integer :person_id
      t.boolean :have_job
      t.text :resume_professional
            
      t.timestamps
    end
    
    create_table :guara_jobs_process_instances do |t|
      t.integer :process_id
      t.date :date_start
      t.date :date_finish
      t.boolean :finished
      t.integer :user_using_process
      t.integer :state

      t.timestamps
    end
    
    create_table :guara_jobs_step_instances do |t|
      t.integer :process_instance_id
      t.timestamps
    end
    
    create_table :guara_jobs_step_instance_attrs do |t|
      t.integer :process_instance_id
      t.integer :step_attr_id
      t.integer :step_id
      t.string :value

      t.timestamps
    end
    
    create_table :guara_jobs_step_instance_attr_multis do |t|
      t.integer :step_instance_attr_id
      t.string :value

      t.timestamps
    end
    
    create_table :guara_jobs_vacancy_specifications_roles do |t|
      t.references :role
      t.references :vacancy_specification

      t.timestamps
    end
    add_index :guara_jobs_vacancy_specifications_roles, :role_id, :name => "guara_jobs_vacancy_spec_roles_id"
    add_index :guara_jobs_vacancy_specifications_roles, :vacancy_specification_id, :name => "guara_jobs_vacancy_spec_id"
    
    create_table :guara_jobs_consultants do |t|
      t.string :name
      t.boolean :enable

      t.timestamps
    end
    
    create_table :guara_jobs_careers do |t|

      t.string :role
      t.date :date_admission
      t.date :date_resignation
      t.decimal :salary, :precision => 10, :scale => 2, :default => 0
      t.text :activities
      
      t.references :professional_experience

      t.timestamps
    end
    
    create_table :guara_jobs_vacancies do |t|
      t.references :process_instance

      t.timestamps
    end
    add_index :guara_jobs_vacancies, :process_instance_id
    
    create_table :guara_jobs_vacancy_scheduling_professionals do |t|
      
      t.string :local
      t.string :description
      t.integer :avaliate
      t.references :consultant
      t.references :professional
      t.references :vacancy
      t.timestamps :date_time
      t.timestamps :date_time_interviewee

      t.timestamps 
    end
    
    add_index :guara_jobs_vacancy_scheduling_professionals, :vacancy_id, :name=> "guara_jobs_vacancy_sch_profs"
    
    create_table :guara_jobs_vacancy_sended_professionals do |t|
      t.references :vacancy_scheduling_professional
      t.datetime :date
      t.integer :step_instance_id

      t.timestamps
    end
    add_index :guara_jobs_vacancy_sended_professionals, :vacancy_scheduling_professional_id, :name=> "guara_jobs_vacancy_sch_profs_send"
    
    create_table :guara_jobs_languages do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :guara_jobs_level_knowledges do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :guara_jobs_professional_languages do |t|
      t.references :language
      t.references :level_knowledge
      t.references :professional

      t.timestamps
    end
    
    create_table :guara_jobs_vacancy_professionals_interviews do |t|
      t.integer :scheduling_id
      t.datetime :date
      t.integer :vacancy_step_id
      t.integer :interview_process_instance_id

      t.timestamps
    end
    add_index :guara_jobs_vacancy_professionals_interviews, :scheduling_id, name: "vacancy_schd_id"
    
  	add_column :guara_jobs_custom_processes, :released,  :boolean
  	add_column :guara_jobs_custom_processes, :source_id, :integer
  	
  	add_column :guara_jobs_vacancy_specifications, :salary_requirement_id, :integer
    remove_column :guara_jobs_vacancy_specifications, :salary_requirements
    
    create_table :guara_jobs_salary_requirements do |t|
      t.string :salary_range

      t.timestamps
    end
    
    add_column :guara_jobs_vacancy_scheduling_professionals, :interested, :boolean
    
    add_column :guara_jobs_vacancy_professionals_interviews, :synthesis, :text
    
    create_table :guara_jobs_vacancy_customer_interviews do |t|
      t.integer :vacancy_sended_professionals_id
      t.integer :vacancy_scheduling_professional_id
      t.datetime :return_date
      t.integer :return_interview
      t.string :motive

      t.timestamps
    end
        
    create_table :guara_jobs_vacancy_professionals_psychological_evaluations do |t|
      t.datetime :date_evaluation
      t.string :path_documents
      t.datetime :date_send_report
      t.integer :vacancy_customer_interview_id
      t.integer :vacancy_scheduling_professional_id

      t.timestamps
    end

    create_table :guara_jobs_vacancy_final_results do |t|
      t.integer :vacancy_scheduling_professional_id
      t.integer :vacancy_professionals_psychological_evaluation_id
      t.integer :result
      t.datetime :work_start_date
      t.string :salary
      t.string :observation

      t.timestamps
    end

    create_table :guara_jobs_attachments do |t|
      t.references :professional
    end

  end
end
