
class FoursquareController < ActionController::Base
  #respond_to :json

  #API_PLACE_SEARCH='https://api.foursquare.com/v2/venues/search?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=20130815&ll=40.7,-74&query=params'

  def places
    places_search = params[:places_search]
    places_search_center = params[:places_search_center]
    @places = client.search_venues(:ll => places_search_center, :query => places_search)
    render :json => @places
  end

  def client
    @client ||= Foursquare2::Client.new(:client_id => Guara::Settings.value('foursquare.client_id'), :client_secret => Guara::Settings.value('foursquare.secret'))
  end

end