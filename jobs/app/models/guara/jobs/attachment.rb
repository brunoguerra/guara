class Guara::Jobs::Attachment < ActiveRecord::Base
	attr_accessible :curriculum, :avatar

	has_attached_file :curriculum

	has_attached_file :avatar, 
		:url => :set_default_url_on_category,
		:styles => { 
	    	:medium => "300x300>", 
	    	:thumb => "100x100>",
	    	:small  => "150x150>",
		}


	def set_default_url_on_category
	 "/assets/professional/:id/:style/:basename.:extension"
	end

	belongs_to :professional

end