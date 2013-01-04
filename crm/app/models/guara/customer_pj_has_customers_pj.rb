module Guara
  class CustomerPjHasCustomersPj < ActiveRecord::Base
    attr_accessible :from, :to
  
    belongs_to :from, class_name: CustomerPj
    belongs_to :to, class_name: CustomerPj
  
  end
end