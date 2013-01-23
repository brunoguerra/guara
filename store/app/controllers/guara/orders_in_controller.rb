
module Guara
  class OrdersInController < Guara::OrdersController

    def index
    	@search = Order.search(params[:search])
    	@order = @search.result().paginate(page: params[:page], :per_page => 10)
    end

    def new
    	@order = Order.new
    	puts '------'
    end



  end
end
