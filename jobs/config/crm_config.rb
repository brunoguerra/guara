puts "customer_modules"

customer_module = {
	:name => :professional,
	:tabs => [{
		:name => :professional,
		:title => I18n.t("jobs.professional.index.link"),
		:url => lambda do |customer|
			customer.professional.nil? ? Guara::Core::Engine.routes.url_helpers.new_customer_professional_path(customer) : customer.professional.base_uri
		end
	}]
}

Guara::Customer.add_module customer_module