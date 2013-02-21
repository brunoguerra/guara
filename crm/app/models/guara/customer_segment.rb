module Guara
  class CustomerSegment < ActiveRecord::Base
    attr_accessible :segment
    belongs_to :customer_pj
    belongs_to :segment, class_name: "BusinessSegment"
    
    validates :segment_id, presence: true
  end
end