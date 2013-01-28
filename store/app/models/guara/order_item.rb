module Guara
  class OrderItem < ActiveRecord::Base
    attr_accessible :order_id, :product_id, :total, :value
  end
end
