module Guara
  class PlacesController < Guara::BaseController
    load_and_authorize_resource
    before_filter :foursquare_filter, :only => [:new]

    def index
      @places = paginate @places
    end

    def new
    end

    def foursquare_filter
      @place.build_geo
      @place.build_address
      @place.enabled = true
      if params[:fq_venue]
        @fq_venue = FoursquareController.new.client.venue(params[:fq_venue])
        if @fq_venue
          @place = Place.find_by_foursquare_venue @fq_venue
        end
      end
    end

    def create
      @place = Place.new(params[:place])
      if @place.save
        redirect_to @place
      else
        render
      end
    end

    def show
    end

  end
end