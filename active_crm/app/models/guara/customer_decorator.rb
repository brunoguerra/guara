Guara::Customer.class_eval do 
	 #SCOPE ALTER NAME => verify_deal
	 scope :verify_scheduled, lambda { |scheduled_id, type_symbol| 
	 	where("#{Guara::Customer.table_name}.customer_type = 'Guara::CustomerPj' AND (select count(*) from #{Guara::ActiveCrm::Scheduled::Deals.table_name} as d 
        	where d.customer_pj_id = #{Guara::Customer.table_name}.id and d.scheduled_id = ?) #{type_symbol} 0", scheduled_id) 
	 }

	def load_scheduled_contacts
		return (Guara::ActiveCrm::Scheduled::Contact.joins(:contact)
		.where("#{Guara::Contact.table_name}.person_id = #{self.id}") || [])
	end
end