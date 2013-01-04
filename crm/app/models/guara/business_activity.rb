module Guara
  class BusinessActivity < ActiveRecord::Base
    attr_accessible :enabled, :name, :business_segment, :notes
  
    belongs_to :business_segment
  end
end