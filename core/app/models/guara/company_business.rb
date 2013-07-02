module Guara
  class CompanyBusiness < ActiveRecord::Base
    attr_accessible :name, :enabled
  
    include ActiveExtend::ActiveDisablable
  
  end
end