module Guara
  class BusinessSegment < ActiveRecord::Base
    attr_accessible :enabled, :name
  
    default_scope order: 'guara_business_segments.name'
  end
end