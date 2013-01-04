module Guara
  class CustomerSegment < ActiveRecord::Base
    # attr_accessible :title, :body
  
    belongs_to :customer_pj
    belongs_to :business_segment, foreign_key: 'segment_id'
  
    validates :customer_pj_id, presence: true
    validates :segment_id, presence: true
  end
end