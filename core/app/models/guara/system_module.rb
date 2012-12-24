module Guara

  class SystemModule < ActiveRecord::Base
    attr_accessible :name
  
    def self.CUSTOMER
      readonly.find_by_name("Customer")
    end
  
    def self.USER
      readonly.find_by_name("User")
    end
  
    def self.CONTACT
      readonly.find_by_name("Contact")
    end
  
  end

end