module Guara
  
  class SystemAbility < ActiveRecord::Base
    attr_accessible :name

    def self.CREATE
       readonly.find_by_name("CREATE")
    end
    def self.READ
      readonly.find_by_name("READ")
    end
    def self.UPDATE
      readonly.find_by_name("UPDATE")
    end
    def self.DELETE
      readonly.find_by_name("DELETE")
    end
  end
end