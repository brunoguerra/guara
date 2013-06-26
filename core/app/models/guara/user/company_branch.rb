module Guara
  class User::CompanyBranch < ActiveRecord::Base
    belongs_to :branch
    belongs_to :user
    attr_accessible :enabled
  end
end
