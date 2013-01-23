
module Guara
  class OrdersController < Guara::StoreBaseController
    load_and_authorize_resource :class => "Guara::Order"
    
    def show
      
    end
    
    def index
    end
    
  end
end
