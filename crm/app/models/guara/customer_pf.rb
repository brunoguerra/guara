module Guara
  class CustomerPf < ActiveRecord::Base
    # attr_accessible :title, :body
  
    attr_protected
  
    has_one	:person	, :as => :customer
    belongs_to	:company	, class_name: "Customer"
    has_many	:history_pfs
  
    def prefix
      "pf"
    end
  end
end