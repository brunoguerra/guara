Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do	
		resources :scheduleds do 
			resources :scheduled_customer_groups do 
				resources :scheduled_contacts
			end
		end
		
		match "/active_crm",    to: "active_crm#index"
		match "/ignore_customer_session",  to: "scheduled_contacts#ignore_customer_session"
  	end
end
