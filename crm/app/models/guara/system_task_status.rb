module Guara
  class SystemTaskStatus < ActiveRecord::Base
    attr_accessible :name
  
    def self.OPENED
      readonly.find_by_name("OPENED")
    end
  
    def self.IN_PROGRESS
      readonly.find_by_name("IN_PROGRESS")
    end
  
    def self.PAUSED
      readonly.find_by_name("PAUSED")
    end
  
    def self.CLOSED
      readonly.find_by_name("CLOSED")
    end
  end
end