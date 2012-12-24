
module Guara
  
  class City < ActiveRecord::Base
    include ActiveExtend::ActiveDisablable
    attr_accessible :name, :state, :state_id
  
    belongs_to :state
  
  end
end