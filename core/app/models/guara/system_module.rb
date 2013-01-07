module Guara

  class SystemModule < ActiveRecord::Base
    attr_accessible :name
  
    def self.ALL
      readonly.find_by_name("All")
    end  
  
    def self.CITY
      readonly.find_by_name("City")
    end
  
    def self.USER
      readonly.find_by_name("User")
    end
  
    def self.CONTACT
      readonly.find_by_name("Contact")
    end    
    
  
  end

end