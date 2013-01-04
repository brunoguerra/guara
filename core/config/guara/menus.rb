
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
                      :user_groups,
                    ]
       }
    
    MAINTENCE =
      {
        :title => "maintenances",
        :prefix => "maintence_guara",
        :items => [
                    :districts,
                    :cities,
                    :states,
                  ]
       }
  end
  
end