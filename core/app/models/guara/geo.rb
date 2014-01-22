module Guara
  class Geo < ActiveRecord::Base
    attr_accessible :lat, :long
    belongs_to :thing, :polymorphic => true

    WHERE_IN_GIS = %{
        ST_DWithin(
          ST_GeographyFromText(
            'SRID=4326;POINT(' || guara_geos.long || ' ' || guara_geos.lat || ')'
          ),
          ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
          %d
        )
      }

    scope :close_to, lambda { |latitude, longitude, distance_in_meters|
      where(Guara::Geo::WHERE_IN_GIS % [longitude, latitude, distance_in_meters])
    }

  end
end
