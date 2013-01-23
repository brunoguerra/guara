module Guara
  class Order < ActiveRecord::Base
    
    attr_accessible :person, :date_finish, :date_init, :payment_date, :payment_state,
                    :payment_type, :person_id, :state, :state_date, :type
    
    belongs_to :person    
    
    has_many :order_items
    
    public
      def state=(state)
        write_attribute :state, state
        self.state_date = Time.now
      end
  
      def self.total_in_on(date)
        where(date_init: date).joins(:order_items).sum("value*total")
      end
  
      def self.total_out_on(date)
        where(date_init: date).joins(:order_items).sum("value*total")
      end
      
  end
end
