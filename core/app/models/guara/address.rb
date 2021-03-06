
module Guara
  
  class Address < ActiveRecord::Base
    attr_accessible :address, :addressable, :city, :city_id, :number, :complement, :country, :country_id, :district, :district_id, :postal_code, :state, :state_id
  
    belongs_to :addressable, :polymorphic => true, dependent: :destroy
    belongs_to :district
    belongs_to :city
    belongs_to :state
    
    def to_s
    	[self.address, ((self.district && self.district.name) || ""), ((self.district && self.district.city && self.district.city.name) || ""), ((self.district && self.district.city && self.district.city.state.name) || "")].join(", ")
    end
  end
end