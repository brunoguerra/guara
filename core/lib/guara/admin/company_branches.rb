
if defined?(ActiveAdmin)
  module Guara
	ActiveAdmin.register CompanyBranch, :namespace => :maintence do
		
		filter :enabled, :as => :select
		filter :name

		#remove default_scope
		scope_to do
			Class.new do
			  def self.guara_company_branches
			    CompanyBranch.unscoped
			  end
			end
		end

		#custom form
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
  end
end
