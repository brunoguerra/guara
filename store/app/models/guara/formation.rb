module
	class Formation < ActiveRecord::Base
		attr_accessible :level_of_education, :course, :situation, :completion_date, :description
						:level_of_education_id, :course_id, :situation_id

		belongs_to :level_of_education
		belongs_to :course
		belongs_to :situation


		

end