
module Guara
  class OrdersInController < Guara::OrdersController

    def index
        params[:search] = {} if params[:search].nil?
        params[:search][:order_type_eq] = OrderType.IN

        @search = Order.search(params[:search])
        @orders = paginate(@search, params[:page], 20)
    end

    def new
    	@order = Order.new
    end

    def create
        @params = params
        set_order_state
        @order = Order.new(@params[:order])
        
        respond_to do |format|
            if @order.save
              format.html { redirect_to(orders_in_path(@order), :notice => 'Order was successfully created.') }
              format.json { render :json => @order, :status => :created, :location => @order}
            else
              format.html { render :action => "new" }
              format.json { render :json => @order.errors, :status => :unprocessable_entity }
            end
        end
    end
 
    def update
        @order = Order.find params[:id]
        respond_to do |format|
            if @order.update_attributes(params[:order])
                format.html { 
                    flash[:success] = t('helpers.forms.new_sucess')
                    redirect_to orders_in_index_path(@order)
                }
                format.json { 
                    render :json=> {
                        success: true, 
                        situation: OrderState.status_translated[@order.state] 
                    } 
                }
            else
                format.html { redirect_to edit_orders_in_path(@order) }
                format.json { render :json=> {success: false} }
            end
        end
    end

    private
    def set_order_state
        state = @params[:budget].to_i == 1 ? OrderState.status[:BUDGET] : OrderState.status[:CONFIRMED]
        @params[:order] = @params[:order].merge(:order_type=>OrderType.IN, :state=> state)
    end

  end
end
