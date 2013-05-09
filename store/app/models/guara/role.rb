module
	class Role < ActiveRecord::Base
		attr_accessible :name :fields_id, :fields

		belongs_to :fields
	end
end