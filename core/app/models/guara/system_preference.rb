module Guara
  class SystemPreference < ActiveRecord::Base
    attr_accessible :default, :property, :value
  end
end
