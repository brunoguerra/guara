module Guara
	class SupplierController < Guara::CustomersController
		load_and_authorize_resource :class => "Guara::Supplier"

		def new
			
		end 

		def create
			params[:customer_pj][:is_supplier] = true
			super
		end

	end 

end