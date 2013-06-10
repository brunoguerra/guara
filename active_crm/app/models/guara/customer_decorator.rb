Guara::Customer.class_eval do 
	 scope :verify_scheduled, lambda { |scheduled_id, type_symbol| 
	 	where("#{Guara::Customer.table_name}.customer_type = 'Guara::CustomerPj' AND (select count(*) from #{Guara::ActiveCrm::ScheduledContact.table_name} as gc 
        	inner join #{Guara::Contact.table_name} as c on (c.id = gc.contact_id) 
        	where c.person_id = #{Guara::Customer.table_name}.id and gc.scheduled_id = ?) #{type_symbol} 0", scheduled_id) 
	 }

	def load_scheduled_contacts
		return (Guara::ActiveCrm::ScheduledContact.joins(:contact)
		.where("#{Guara::Contact.table_name}.person_id = #{self.id}") || [])
	end
end