module Guara
  class PlacesController < Guara::BaseController
    load_and_authorize_resource

    def index

    end

    def new
      @place.build_geo
    end

  end
end