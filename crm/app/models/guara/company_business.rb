module Guara
  class CompanyBusiness < ActiveRecord::Base
    attr_accessible :name, :enabled
  
    include ActiveDisablable
  
  end
end