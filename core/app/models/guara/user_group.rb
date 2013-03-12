module Guara

  class UserGroup < ActiveRecord::Base
    attr_accessible :enabled, :name, :system
    
    include Skilled
  
    #scope
    default_scope where("enabled = TRUE")
  
    #abilities
    has_many :abilities, class_name: "UserAbility", :as => :skilled
    
    has_many :primary_users, foreign_key: "primary_group_id", :class_name => "Guara::User"
  end
end
