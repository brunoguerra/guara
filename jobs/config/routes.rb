Guara::Core::Engine.routes.prepend do
  #resources :products


	scope module: 'jobs' do
		resources :customers do
			resources :professionals
		end


		resources :professional

		match "/jobs",    to: "jobs#index"

		match "/professionals/search", to: "professionals#search"
	end
  
  
  
end
