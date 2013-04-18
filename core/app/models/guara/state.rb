module Guara

  class State < ActiveRecord::Base
    attr_accessible :acronym, :name

    State.order("name_at DESC")
    
    has_many :city
  end

end