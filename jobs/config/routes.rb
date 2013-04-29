
Guara::Core::Engine.routes.prepend do
  #resources :products


	scope module: 'jobs' do
		
		resources :jobs_customers, contoller: "Guara::CustomersController" do
			resources :professionals
		end

		resources :professional

		match "/jobs",    to: "jobs#index"
		
		match "/custom_process_steps", :to => 'custom_process#custom_process_steps'
		match "custom_process/add_attr_to_steps", :to => 'custom_process#add_attr_to_steps'
		match "custom_process/step_set_widget", :to => 'custom_process#step_set_widget'
		match "custom_process/release", :to => 'custom_process#set_release'
		match "custom_process/set_enabled_custom_process", :to => 'custom_process#set_enabled_custom_process'

		match "process_instance/alter_state_process_instance", :to => 'process_instance#alter_state_process_instance'
		match "process_instance/finish_process_instance", :to => 'process_instance#finish_process_instance'
		match "process_instance/multiselect_customer_pj", to: "process_instance#multiselect_customer_pj"
		match "process_instance/show_step", :to => 'process_instance#show_step'
		 
		resources :custom_process
		resources :step
		  
		resources :process_instance
		
		match "/professionals/search_select", to: "professionals#search_select"
		match "/professionals/search", to: "professionals#search"
		match "/interviewer_professional/show_embeded_process", :to => "interviewer_professionals#show_embeded_process"
		match "/professionals_synthesis/show_synthesis", :to => "professionals_synthesis#show_synthesis"
		match "/vacancy_sended_professionals/send_email_customer_pj", :to => "vacancy_sended_professionals#send_email_customer_pj"

		resources :vacancies do
		  resource :scheduler_professional, controller: "SchedulerProfessionals"
		  resource :interviewer_professional, controller: "InterviewerProfessionals"
		  resource :synthesis_professional, controller: "ProfessionalsSynthesis"
		  resource :vacancy_sended_professional, controller: "VacancySendedProfessionals"
		  resource :vacancy_customer_interview, controller: "VacancyCustomerInterview"
		  resource :vacancy_psychological_evaluation_evaluation, controller: "VacancyProfessionalsPsychologicalEvaluation" 
		  resource :vacancy_final_result, controller: "VacancyFinalResult"
	  end

	end
  
  
  
end
