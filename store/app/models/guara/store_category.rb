module Guara
  class StoreCategory < ActiveRecord::Base
    attr_accessible :enabled, :name, :parent_id
    
    belongs_to :parent, class_name: "Guara::StoreCategory"

    has_many :product_categories  
  	has_many :products, :through => :product_categories 
    
    
  end
end
