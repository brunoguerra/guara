Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do	
		resources :scheduleds do 
			resources :scheduled_customer_groups do 
				resources :scheduled_contacts
			end
		end

		resources :scheduled_deals do
			get 'multiselect_scheduleds', :on => :collection
			get 'multiselect_group', :on => :collection
		end
		
		match "/active_crm",    to: "active_crm#index"
		match "/ignore_customer_session",  to: "scheduled_contacts#ignore_customer_session"
		match "/close_negociation",  to: "scheduled_contacts#close_negociation"
  	end
end
