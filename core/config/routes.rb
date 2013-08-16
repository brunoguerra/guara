Guara::Core::Engine.routes.draw do

  devise_for :users, :class_name => 'Guara::User', :module => :devise
  root to: Guara::Core::Environment.new.routes_home_path(true)

  ActiveAdmin.routes(self)

  resources :system_extensions

  resources :company_businesses

  resources :districts
  resources :business_departments
  resources :task_types
  resources :system_task_status

  resources :business_activities
  resources :business_segments

  match '/home',    to: 'static_pages#help', as: :home
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  get '/users/company_branch/:company_branch_id/change', to: 'sessions#change', as: 'change_branch_user_session'

  #authenticate
  #match '/signup',  to: 'users#new'
  #match '/signin',  to: 'sessions#new'
  #match '/signout', to: 'sessions#destroy', via: :delete

  #match '/sigup', to: ''

  #resources
  resources :users do
  #  resources :sessions
    resources :abilities, controller: "UsersAbilities"
  end

  resources :user_groups do
    resources :abilities, controller: "UserGroupsAbilities"
  end
  
  #resources :sessions #,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]

end

if !Rails.application.nil? && !Rails.application.routes.url_helpers.respond_to?(:root_path)
  Rails.application.routes.prepend do
    root to: Rails.application.config.guara.routes_home_path()
  end
end