puts "customer_modules"


I18n.load_path += Dir[File.expand_path('../locales/*.{rb,yml}', __FILE__)] # TORNA  A TRADUÇÃO FUNCIONAL EM UM INITIALIZE

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