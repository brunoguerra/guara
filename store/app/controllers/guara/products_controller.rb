
module Guara
  class ProductsController < Guara::StoreBaseController
    load_and_authorize_resource :class => "Guara::Product"
    def index
    end
  end
end
