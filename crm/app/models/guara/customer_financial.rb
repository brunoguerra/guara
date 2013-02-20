module Guara
  class CustomerFinancial < ActiveRecord::Base
    attr_accessible :customer, :billing_address_different, :contact_leader_id,
                    :payment_pending, :payment_pending_message, :notes
    
    has_one :customer
    
    has_many :billing_addresses, :as => :addressable, :class_name => "Address"
    belongs_to :leader, :conditions => "CUSTOMER_ID = CustomerFinancials.CUSTOMER_ID", :touch => true, class_name: "Contact"
    
  end
end