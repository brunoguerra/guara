module Guara
  class District < ActiveRecord::Base
  
    attr_accessible :name, :city, :city_id, :enabled
  
    belongs_to :city
  end
end