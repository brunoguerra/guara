module Guara
  module Core

    def self.routes router
      router.instance_exec :guara do
        match "/users/init", :to => 'users#init'
        devise_for :users, :class_name => 'Guara::User', :module => :devise
        root to: Guara::Core::Environment.new.routes_home_path(true)

        authenticate :user do
          get 'users/connect/:network', :to => redirect("/users/auth/%{network}")
        end

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
          get :sign_out, on: :collection
          resources :abilities, controller: "UsersAbilities"
        end

        resources :user_groups do
          resources :abilities, controller: "UserGroupsAbilities"
        end
        
        #resources :sessions #,   only: [:new, :create, :destroy]
        resources :microposts, only: [:create, :destroy]

        resources :places
      end
    end
  end
end