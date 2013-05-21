module Guara
  class OrderItem < ActiveRecord::Base
    attr_accessible :order_id, :product_id, :product, :total, :price, :price_total

    belongs_to :product
    belongs_to :order

    #validates :order_id, :product_id, :total, :price, :presence => true
    
    def price_total
    	(total || 0)*(price || 0)
    end

    def price_total=(val)
    	//
    end
  end
end
