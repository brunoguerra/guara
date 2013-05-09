module Guara
	class Function < ActiveRecord::Base
		attr_accessible :name, :role, :role_id, :salary_requirements

		belongs_to :professional
		has_many :role
  
	end
end