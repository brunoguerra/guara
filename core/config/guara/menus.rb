
module Guara
  module Menus
    groups = [:customers, :maintence, :help, :current_user]


    ADMINISTRATION =
            {
              :title => "administration",
              :namespace => "main_app.admin",
              :items => [
                          [:users, "main_app.users_path()"],
                          :user_groups,
                        ]
             }
    
    MAINTENCE =
            {
              :title => "maintenances",
              :namespace => "main_app.maintence",
              :items => [
                          :districts,
                          :cities,
                          :states,
                          :business_activities,
                          :business_segments,
                          :business_departments,
                          :company_businesses,
                          :task_types,
                        ]
             }
  end
  
end