class Guara::Jobs::Attachment < ActiveRecord::Base
	attr_accessible :curriculum, :avatar

	has_attached_file :curriculum

	has_attached_file :avatar, :styles => { 
	    :medium => "300x300>", 
	    :thumb => "100x100>" 
	}

	belongs_to :professional

end