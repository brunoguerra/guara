Guara::Core::Engine.routes.prepend do
  
  resources :customers do
    get :autocomplete_business_segment_name, :on => :collection
    get :autocomplete_business_activity_name, :on => :collection
    
    get :multiselect_business_segments, :on => :collection
    get :multiselect_business_activities, :on => :collection
    
    get :customer_pj, :on => :collection
    
    get :multiselect_customers_pj, :on => :collection
    
    
    resources :contacts do
      post :multi, :on => :collection
    end
    
    resources :tasks do
      resources :feedbacks
    end
  end

  
end
