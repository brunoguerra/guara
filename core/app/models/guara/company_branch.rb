module Guara
  class CompanyBranch < ActiveRecord::Base
    has_one :address, :as => :addressable, :class_name => "Guara::Address"
    attr_accessible :enabled, :name, :address, :address_attributes
    include ActiveExtend::ActiveDisablable

    accepts_nested_attributes_for :address
    
  end
end
