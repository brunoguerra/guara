class Guara::Jobs::Attachment < ActiveRecord::Base
	attr_accessible :curriculum, :avatar

	attr_accessor :curriculum_file_name, :avatar_file_name

	has_attached_file :curriculum

	has_attached_file :avatar, 
		:styles => { 
	    	:medium => "300x300>", 
	    	:small  => "200x200>",
	    	:thumb => "100x100>"
		}

	belongs_to :professional

end