
module Guara
  class OrdersInController < Guara::OrdersController

    def index
    	@search = Order.search(params[:search])
        @order = @search.result().paginate(page: params[:page], :per_page => 20)
    end

    def new
    	@order = Order.new
        @person = Person.find(:all)
        @order.person = Person.new
    end

     def create
            @order = Order.new(params[:order])

            respond_to do |format|
            if @order.save
              format.html { redirect_to(orders_in_path(@order), :notice => 'Contact was successfully created.') }
              format.json { render :json => @order, :status => :created, :location => @order}
            else
              format.html { render :action => "new" }
              format.json { render :json => @order.errors, :status => :unprocessable_entity }
            end
            end
      end

 
    def update
        @order = Order.find params[:id]
        if @order.update_attributes(params[:order])
            flash[:success] = t(helpers.forms.new_sucess)
            redirect_to orders_in_index_path(@order.id)
        else
            redirect_to orders_in_index_path
        end

    end

    def destroy
        @order = @order.find(params[:id])
        @order.destroy

        respond_to do |format|
            format.html { redirect_to orders_in_index_path }
            format.json { head :ok}
        end
    end



  end
end
