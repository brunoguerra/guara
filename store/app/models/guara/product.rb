module Guara
  class Product < Spree::Product

    include ActiveExtend::ActiveDisablable

    after_initialize :ensure_master
    
    has_many :product_categories
    has_many :categories, through: :product_categories
    
    belongs_to :primary_category, class_name: 'Guara::StoreCategory'
    
    attr_accessor :primary_category
    
    attr_accessible :stock, :category_ids, :enabled

    alias_method :stock, :on_hand
    alias_method :current_stock, :on_hand
    alias_method :stock=, :on_hand=
    
    def in_stock?
      stock > 0
    end
    
    def manufacturer
      manufacturers = product_properties.joins(:property).where('name #{Guara::SQL_LIKE} "manufacturer"')
      if manufacturers.size > 0
        manufacturers[0].value
      else
        nil
      end
    end
    
    def manufacturer(manufacturer)
      
    end
  end
end
