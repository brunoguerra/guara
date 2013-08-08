module Guara
  class SystemPreference < ActiveRecord::Base
    attr_accessible :default, :property, :value

    def self.property(name, default=nil)
      property = find_by_property(name)
      return default if property==nil
      return property.value || property.default
    end
  end
end
