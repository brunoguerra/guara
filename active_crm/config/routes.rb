
Guara::Core::Engine.routes.prepend do
	scope module: 'active_crm' do	
		resources :teste
  end

	end
end
