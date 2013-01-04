module Guara
  class CustomerPf < ActiveRecord::Base
    # attr_accessible :title, :body
  
    attr_protected
  
    has_one	:customer	, :as => :person
    belongs_to	:company	, class_name: "Customer"
    has_many	:history_pfs
  
    def prefix
      "pf"
    end
  end
end