module Guara
  class BusinessDepartment < ActiveRecord::Base
    attr_accessible :enabled, :name
  end
end