
module Guara
  
  class Address < ActiveRecord::Base
    attr_accessible :address, :addressable, :city, :city_id, :complement, :country, :country_id, :district, :district_id, :postal_code, :state, :state_id
  
    belongs_to :addressable, :polymorphic => true, dependent: :destroy
    belongs_to :district
    belongs_to :city
    belongs_to :state
    
    validates :addressable, presence: true
  end
end