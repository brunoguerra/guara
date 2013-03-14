
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
                      [:users, "users_path()"],
                      [:user_groups, "user_groups_path()"]
                    ]
       }
    
    MAINTENCE =
      {
        :title => "maintenances",
        :prefix => "maintence_guara",
        :items => [
                    { name: :districts, resource: Guara::District },
                    { name: :cities, resource: Guara::City },
                    { name: :states, resource: Guara::State },
                  ]
       }
  end
  
end