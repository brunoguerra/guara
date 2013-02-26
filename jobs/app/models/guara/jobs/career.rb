
  class Guara::Jobs::Career < ActiveRecord::Base
     attr_accessible :activities, :date_admission,:date_resignation, :role, 
     				 :salary, :professional_experience_id

     validates :activities, :date_admission,:role, :salary, :presence => true

	 belongs_to :professional_experience


  end

