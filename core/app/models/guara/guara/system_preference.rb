module Guara
  class Guara::SystemPreference < ActiveRecord::Base
    attr_accessible :default, :property, :value
  end
end
