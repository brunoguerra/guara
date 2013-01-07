module Guara
  class TaskType < ActiveRecord::Base
    attr_accessible :enabled, :name, :company_business, :company_business_id
  
    include ActiveExtend::ActiveDisablable
  
    belongs_to :company_business
  
    def self.for_business(company_business)
      where(company_business_id:company_business.id)
    end
  
  end
end