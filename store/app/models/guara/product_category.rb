module Guara
  class ProductCategory < ActiveRecord::Base
    attr_accessible :category, :product
    
    belongs_to :product
    belongs_to :category, class_name: "Guara::StoreCategory"
    
  end
end
