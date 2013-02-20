module Guara
  
  class LevelOfEducation < ActiveRecord::Base
    include ActiveExtend::ActiveDisablable
    attr_accessible :name
  
  end
end