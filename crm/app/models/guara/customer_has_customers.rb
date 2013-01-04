module Guara
  class CustomerHasCustomers < ActiveRecord::Base
    attr_accessible :from, :to
  
    belongs_to :from, foreign_key: "from", class_name: Customer
    belongs_to :to, foreign_key: "to", class_name: Customer
  
  end
end