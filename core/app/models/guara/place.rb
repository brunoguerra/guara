module Guara
  class Place < ActiveRecord::Base
    attr_accessible :enabled, :name, :geo_attributes, :geo, :address_attributes, :external_id

    has_one :geo, :as => :thing
    has_one :address, :as => :addressable

    accepts_nested_attributes_for :address, :reject_if => lambda { |a| a[:address].blank? }
    accepts_nested_attributes_for :geo, :reject_if => lambda { |a| a[:lat].blank? }


    def self.find_by_foursquare_venue(fq_venue)
      puts fq_venue[:id].to_yaml
      place = find_by_external_id fq_venue[:id]
      unless place 
        place = self.new
        place.build_address
        place.address.address = fq_venue[:location][:address]
        if (fq_venue[:location][:city])
          place.address.city = Guara::City.where("name ilike '#{fq_venue[:location][:city].downcase}'").first
        end

        if !place.address.city && (fq_venue[:location][:state])
          state = Guara::State.where("acronym ilike '#{fq_venue[:location][:state].downcase}'").first
          state = Guara::State.create(name: fq_venue[:location][:state].downcase) unless state
          place.address.city = Guara::City.create(name: fq_venue[:location][:city], state_id: state.id)
        end

        place.build_geo
        place.geo.attributes = { lat: fq_venue[:location][:lat], long: fq_venue[:location][:lng] }
        place.name = fq_venue[:name]
        place.external_id = fq_venue[:id]
      end
      place
    end
  end
end
