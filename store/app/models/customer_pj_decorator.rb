Guara::CustomerPj.class_eval do 
	
	attr_writer :is_supplier

	before_save :save_supplier


	def is_supplier=(is_supplier)
		@is_supplier = is_supplier
	end

	def is_supplier()
		@is_supplier || false
	end

	private
	def save_supplier
		if self.id.nil? and self.is_supplier
			raise self.to_yaml
		end
	end

end