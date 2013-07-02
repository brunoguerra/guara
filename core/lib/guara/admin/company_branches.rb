
if defined?(ActiveAdmin)
  module Guara
	    ActiveAdmin.register CompanyBranch, :namespace => :maintence do
	    	#index do
	    	#	column :actions do |branch|
	      	#		link_to "Company Branch", [:maintence, branch, :address]
	    	#	end
	    	#end

	    	form do |f|
			  f.inputs "Details" do
			    f.input :name
			    f.input :enabled
			  end

			  f.inputs "Address", :for => [:address, f.object.address || f.object.build_address] do |address|
		      address.inputs :address, :district, :complement, :postal_code
			  end

			  f.actions
			end
    end

    #ActiveAdmin.register Address, :namespace => :maintence do
   # 	belongs_to :company_branch
   # end
  end
end
