Guara::Customer.class_eval do 
	 scope :customer_contact, lambda { |groups_id| 
	 		where("customer_type = 'Guara::CustomerPj' AND 
		 		(select count(*) from #{Guara::ActiveCrm::Scheduled::Deals.table_name} as d 
	        	where d.customer_pj_id = #{Guara::Customer.table_name}.id and d.groups_id = ?) = 0", groups_id) 
	 }

	 scope :customer_scheduled, lambda { |group| 
		 	deals    = Guara::ActiveCrm::Scheduled::Deals.table_name
		 	customer = Guara::Customer.table_name
		 	contact  = Guara::ActiveCrm::Scheduled::Contact.table_name
	 		where("customer_type = 'Guara::CustomerPj' AND 
		 		((select count(*) from #{deals} as d where 
		 			d.customer_pj_id = #{customer}.id and d.groups_id = ? 
	        	AND d.closed = false AND 
	        	(	select count(*) from #{contact} as con 
	        		where con.deal_id = d.id and 
	        		con.result = #{Guara::ActiveCrm::Scheduled::Contact.results()[:scheduling]} 
	        		AND enabled = TRUE) > 0 ) > 0) ", group) 
	 		
	 }

	def load_scheduled_contacts(groups_id)
		return (Guara::ActiveCrm::Scheduled::Contact.joins(:contact, :deal)
		.where("#{Guara::ActiveCrm::Scheduled::Deals.table_name}.groups_id = #{groups_id} AND 
				#{Guara::Contact.table_name}.person_id = #{self.id} AND 
				result = #{Guara::ActiveCrm::Scheduled::Contact.results()[:scheduling]} AND enabled = TRUE ") || [])
	end
end