module Guara
  class BusinessActivity < ActiveRecord::Base
    attr_accessible :enabled, :name, :business_segment, :business_segment_id, :notes
    
    belongs_to :business_segment
  end
end