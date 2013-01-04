
require "active_extend"

module Guara

  mattr_accessor :person_class

  def self.user_class
    if @@user_class.is_a?(String)
      @@user_class.constantize
    end
  end

  module Crm
  end

end

require "guara/crm/engine"