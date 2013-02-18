module Guara

	class SupplierController < Guara::StoreBaseController 
		load_and_authorize_resource :class => "Guara::Supplier"


		def new
			@supplier = Order.new
		end # FIM NEW 

		def create
			@supplier = Supplier.new(params[:supplier])

			respond_to do |format|
            if @supplier.save
              format.html { redirect_to(orders_in_path(@supplier), :notice => 'Supplier was successfully created.') }
              format.json { render :json => @supplier, :status => :created, :location => @supplier}
            else
              format.html { render :action => "new" }
              format.json { render :json => @supplier.errors, :status => :unprocessable_entity }
            end
            end
		end # FIM MODULE

	end # FIM CLASS

end # FIM MODULE