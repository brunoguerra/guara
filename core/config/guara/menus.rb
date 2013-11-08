
module Guara
  module Menus
    groups = [:customers, :maintence, :help, :current_user]

    

    MODULES =
      {
      :modules => 
        {
          :title => "modules",
          :items => []
        }
      }
      
    
    ADMINISTRATION =
      {
        :title =>   "administration",
        :prefix =>  "admin_guara",
        :items =>   [
                      [:users, "guara.users_path()"],
                      [:user_groups, "guara.user_groups_path()"]
                    ]
       }
    
    MAINTENCE =
      {
        :title => "maintenances",
        :prefix => "maintence_guara",
        :items => [
                    { name: :districts, resource: Guara::District, path: "guara.maintence_guara_districts_path()" },
                    { name: :cities, resource: Guara::City, path: "guara.maintence_guara_cities_path()" },
                    { name: :states, resource: Guara::State, path: "guara.maintence_guara_states_path()" },
                    { name: :company_branches, resource: Guara::CompanyBranch, path: "guara.maintence_guara_company_branches_path()" },
                    { name: :places, resource: Guara::Place, path: "guara.places_path()" },
                  ]
       }
  end
  
end