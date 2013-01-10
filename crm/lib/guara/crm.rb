
require "active_extend"

module Guara

  mattr_accessor :person_class
  
  def self.user_class
    if @@user_class.is_a?(String)
      @@user_class.constantize
    end
  end

  module Crm
    TASKS_DUE_CRITICAL_DAYS_REMAINING = 4
  end
end


require "guara/crm/engine"