module Guara
  class CustomerPf < ActiveRecord::Base  
    attr_accessible :gender, :civil_state, :country, :company

    attr_protected
  
    has_one	:person	, :as => :customer
    has_many	:history_pfs
  
    def prefix
      "pf"
    end
  end
end