module Guara

  class UserGroup < ActiveRecord::Base
    attr_accessible :enabled, :name, :system
  
    #scope
    default_scope where("enabled = TRUE")
  
    #abilities
    has_many :abilities, class_name: "UserAbility", :as => :skilled
  end
end
