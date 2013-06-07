

Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do	
		resources :scheduleds do 
			resources :scheduled_customer_groups
			resources :scheduled_contacts
		end
		
		match "/active_crm",    to: "active_crm#index"
  	end
end
