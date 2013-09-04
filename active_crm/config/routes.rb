Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do
		resources :scheduleds do
			get :customers
			resources :scheduled_groups do
				resources :scheduled_contacts do
					post :next_customer, on: :collection
					post :ignore_customer, on: :collection
					post :update_activity
				end
			end
		end

		resources :scheduled_deals do
			get 'multiselect_scheduleds', :on => :collection
			get 'multiselect_group', :on => :collection
			get 'multiselect_customer', :on => :collection
		end

		resources :scheduled_contacts_reports
		
		match "/active_crm",    to: "active_crm#index"
		match "/close_negociation",  to: "scheduled_contacts#close_negociation"

		resources :scheduled_report, only: [:index] do
			get :print, on: :collection
		end
	end
end
