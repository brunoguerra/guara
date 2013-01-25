module Guara
  class OrderItem < ActiveRecord::Base
    attr_accessible :order_id, :product_id, :product, :total, :price

    belongs_to :product


    def price_total
    	(total || 0)*(price || 0)
    end

    def price_total=
    	//
    end
  end
end
