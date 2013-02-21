module Guara
  class CustomerPj < ActiveRecord::Base
    attr_accessible :segments, :activities, :fax, :total_employes, :annual_revenues
    #attr_protected
  
    #person
    has_one	:person, :as => :customer
  
    #segments
    has_many :customer_segments
  
    #não funcionou
    #has_many :segments, :class_name => 'customer_segment'
    has_many :segments, :through => :customer_segments, source: :segment
  
    #activities
    has_many :customer_activities
    has_many :activities, :through => :customer_activities, source: :activity
  
    has_many :associations, foreign_key: "from_id", class_name: "Guara::CustomerPjHasCustomersPj"
    has_many :associateds, through: :associations, source: :to
  
    has_many :reverse_associations, foreign_key: "to_id",
                                       class_name:  "Guara::CustomerPjHasCustomersPj",
                                       dependent:   :destroy
    has_many :associates, through: :reverse_associations, source: :from          
  
    #many-to-many helpers <-----------------------------------
  
    def new_customer_segments_attributes=(segment_attributes)
      segment_attributes.each do |attributes|
        segments.build(attributes)
      end
    end
  
    #after_update :save_customer_segments
  
    def existing_customer_segment_attributes=(segment_attributes)
      segments.reject(&:new_record?).each do |segment|
        attributes = segment_attributes[segment.id.to_s]
        if attributes
          segment.attributes = attributes
        else
          segment.delete(segment)
        end
      end
    end
  
    def save_customer_segments
      segments.each do |segment|
        segment.save(false)
      end
    end
  
    # ------------------>
  
  
    def prefix
      "pj"
    end
  
    def associate_to!(customer_pj)
      associations.create!(to: customer_pj)
    end
  
    def name
      customer.name
    end
  
  end
end