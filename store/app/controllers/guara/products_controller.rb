require_dependency "guara/store/store_controller"

module Guara
  class ProductsController < Guara::StoreBaseController
    load_and_authorize_resource :class => "GuaraStore::Product"
    def index
    end
  end
end
