module Guara
  class Scheduled::CustomerGroup < ActiveRecord::Base
    attr_accessible :business_activities, :business_segments, :employes_max, :employes_min
  end
end
