

Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do	
		resources :scheduleds
		match "/active_crm",    to: "active_crm#index"
  	end
end
