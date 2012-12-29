module Guara
  class SystemExtension < ActiveRecord::Base
    attr_accessible :enabled, :name
  end
end
