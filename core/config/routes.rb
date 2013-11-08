Guara::Core::Engine.routes.draw do

  Guara::Core.routes self

  ActiveAdmin.routes self

  match 'gmaps', to: 'static_pages#gmaps'
  match 'foursquare/places', to: 'foursquare#places'
end

if !Rails.application.nil? && !Rails.application.routes.url_helpers.respond_to?(:root_path)
  Rails.application.routes.prepend do
    root to: Rails.application.config.guara.routes_home_path()
  end
end