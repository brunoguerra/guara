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

		match "process_instance/alter_state_process_instance", :to => 'process_instance#alter_state_process_instance'
		match "process_instance/show_step", :to => 'process_instance#show_step'
		 
		resources :custom_process
		resources :step
		  
		resources :process_instance

		match "/professionals/search", to: "professionals#search"
		match "/interviewer_professional/show_embeded_process", :to => "interviewer_professionals#show_embeded_process"

		resources :vacancies do
		  resource :scheduler_professional, controller: "SchedulerProfessionals"
		  resource :interviewer_professional, controller: "InterviewerProfessionals"
		  resource :vacancy_sended_professional, controller: "VacancySendedProfessionals"
	  end

	end
  
  
  
end
