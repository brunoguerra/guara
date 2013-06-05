module Guara
	class SupplierController < Guara::BaseController
		load_and_authorize_resource :class => "Guara::Supplier"

		def new
			@supplier = Supplier.new.build_person(:customer_type=> Guara::Supplier.to_s)
		end 

		def create
			
		end

	end 

end