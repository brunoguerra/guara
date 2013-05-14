module Guara
  class Order < ActiveRecord::Base
    
    attr_accessible :person, :date_finish, :date_init, :payment_date, :payment_state, :items,
                    :payment_type, :payment_parts, :person_id, :state, :state_date, 
                    :order_type, :products, :items_attributes

    #validates :person_id, :date_init, :state, :order_type, :presence => true

    before_save :update_stock

    belongs_to :person
    belongs_to :spree_payment_method, foreign_key: :payment_type
    
    has_many :items, class_name: "Guara::OrderItem"
    has_many :products, through: :items

    accepts_nested_attributes_for :items, :reject_if => proc { |att| (att['_destroy'] == '1') },
    :allow_destroy => true

    def is_budget?
      (self.state == OrderState.status[:BUDGET])
    end

    def is_confirmed?
      (self.state == OrderState.status[:CONFIRMED])
    end

    def state=(state)
      write_attribute :state, state
      self.state_date = Time.now
    end

    def update_stock
      if self.state == OrderState.status[:CONFIRMED] and self.state_was != self.state
        if self.order_type == OrderType.IN
            self.items.each do |item|
              item.product.update_attribute(:stock, (item.product.stock + item.total))
            end
        else
            self.items.each do |item|
              item.product.update_attribute(:stock, (item.product.stock - item.total))
            end
        end
      end
    end
  
    def self.total_in_on(date)
      where(date_init: date).joins(:items).sum("price*total")
    end

    def self.total_out_on(date)
      where(date_init: date).joins(:items).sum("price*total")
    end
      
  end
end
