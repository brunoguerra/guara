module Guara
  class OrdersController < Guara::StoreBaseController
    load_and_authorize_resource :class => "Guara::Order"



=begin   
	
	 def edit
    	@order = Order.find params[:id]
    end

    def create
    	@order = Order.new(params[:product])
    	if @order.save
    		flash[:success] = t("helpers.forms.new_sucess")
    		redirect_to order_path(@order.id)
    	else
    		redirect_to new_order_path
    	end
    end

    def update
    	@order = Order.find params[:id]
    	if @order.update_attributes(params[:order])
    		flash[:success] = t(helpers.forms.new_sucess)
    		redirect_to order_path(@order.id)
    	else
    		redirect_to new_order_path
    	end

    end

=end
    
  end
end
