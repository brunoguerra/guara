module Guara
  class CompanyBranch < ActiveRecord::Base
    has_one :address
    attr_accessible :enabled, :name
  end
end
