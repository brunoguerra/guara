
module Guara
  module Menus
    groups = [:customers, :maintence, :help, :current_user]


    ADMINISTRATION =
            {
              :title => "administration",
              :namespace => "admin_guara",
              :items => [
                          [:users, "users_path()"],
                          :user_groups,
                        ]
             }
    
    MAINTENCE =
            {
              :title => "maintenances",
              :namespace => "maintence_guara",
              :items => [
                          :districts,
                          :cities,
                          :states,
                        ]
             }
  end
  
end