
module Guara
  
  class Address < ActiveRecord::Base
    attr_accessible :address, :addressable, :city_id, :complement, :country_id, :district_id, :postal_code, :state_id
  
    belongs_to :addressable, :polymorphic => true, dependent: :destroy
  
    validates :addressable, presence: true
  end
end