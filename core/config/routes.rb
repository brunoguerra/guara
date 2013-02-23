Guara::Core::Engine.routes.draw do

  resources :system_extensions


  ActiveAdmin.routes(self)

  resources :company_businesses

  resources :districts
  resources :business_departments
  resources :task_types
  resources :system_task_status

  devise_for :users, :class_name => 'Guara::User', :module => :devise #, :controllers => { :sessions => "sessions" } do
#    #get "/signup" => "devise/registrations#new", :as => 'user_signup'
#    #get '/logout' => 'devise/sessions#destroy', :as => 'user_logout'
#    #get '/login' => "devise/sessions#new", :as => 'user_login'
#    get 'get_token' => 'sessions#get_token'
#    match 'sessions', :to => 'static_pages#home'
#  end

  resources :business_activities
  resources :business_segments

  root to: 'static_pages#home'
  
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  
  #authenticate
  #match '/signup',  to: 'users#new'
  #match '/signin',  to: 'sessions#new'
  #match '/signout', to: 'sessions#destroy', via: :delete
  
  #match '/sigup', to: ''
  
  #resources
  resources :users do
  #  resources :sessions
    resources :abilities
  end
  #resources :sessions #,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]

end