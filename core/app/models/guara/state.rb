module Guara

  class State < ActiveRecord::Base
    attr_accessible :acronym, :name
  end

end