Guara::Core::Engine.routes.prepend do
  
  resources :customers do
    get :autocomplete_business_segment_name, :on => :collection
    get :autocomplete_business_activity_name, :on => :collection
    
    get :autocomplete_customers_name, :on => :collection
    
    get :multiselect_business_segments, :on => :collection
    get :multiselect_business_activities, :on => :collection
    get :multiselect_customers, :on => :collection
    
    
    get :customer_pj, :on => :collection
    
    get :multiselect_customers_pj, :on => :collection
    get :multiselect_customers_pj_customer_id, :on => :collection


    get :load_cities, :on => :collection
    get :load_districts, :on => :collection
    
    resources :contacts do
      post :multi, :on => :collection
    end

    get :customer_association, :on => :member
    
    resources :tasks do
      resources :feedbacks
    end

  end

  match '/exporter/contacts', :to => 'contacts#exporter', :as => :exporter_contacts
  match '/exporter/manager', :to => 'contacts#manager', :as => :manager_contacts
end
