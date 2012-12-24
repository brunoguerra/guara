require_dependency "guara_store/application_controller"

module GuaraStore
  class ProductsController < ApplicationController
    load_and_authorize_resource :class => "GuaraStore::Product"
    def index
    end
  end
end
