puts "customer_modules"


I18n.load_path += Dir[File.expand_path('../locales/*.{rb,yml}', __FILE__)] # TORNA  A TRADUÇÃO FUNCIONAL EM UM INITIALIZE

customer_module = {
	:name => :professional,
	:tabs => [{
		:name => :professional,
		:title => I18n.t("jobs.professional.index.link"),
		:url => lambda do |customer|
			if !customer.nil? && !customer.new_record?
			  if customer.professional.nil?
			    Guara::Core::Engine.routes.url_helpers.new_jobs_customer_professional_path(customer)
			  else
			    customer.professional.base_uri
			  end
			end
		end,
		:visible => lambda do |customer|
			!customer.nil? && !customer.new_record? && (customer.customer.is_a?(Guara::CustomerPf))
	  end
	}]
}

Guara::Customer.add_module customer_module