Guara::Customer.class_eval do 
	has_many :deals, :class_name => Guara::ActiveCrm::Scheduled::Deal

=begin
	 scope :customer_scheduled, lambda { |group| 
		 	deals    = Guara::ActiveCrm::Scheduled::Deal.table_name
		 	customer = Guara::Customer.table_name
		 	contact  = Guara::ActiveCrm::Scheduled::Contact.table_name
	 		where("customer_type = 'Guara::CustomerPj' AND 
		 		((select count(*) from #{deals} as d where 
		 			d.customer_id = #{customer}.id and d.group_id = ? 
	        	AND d.closed = false AND 
	        	(	select count(*) from #{contact} as con 
	        		where con.deal_id = d.id and 
	        		con.result = #{Guara::ActiveCrm::Scheduled::Contact.results()[:scheduling]} 
	        		AND enabled = TRUE) > 0 ) > 0) ", group) 
	 		
	 }

	def load_scheduled_contacts(group_id)
		return (Guara::ActiveCrm::Scheduled::Contact.joins(:contact, :deal)
		.where("#{Guara::ActiveCrm::Scheduled::Deal.table_name}.group_id = #{group_id} AND 
				#{Guara::Contact.table_name}.person_id = #{self.id} AND 
				result = #{Guara::ActiveCrm::Scheduled::Contact.results()[:scheduling]} AND enabled = TRUE ") || [])
	end
=end
end