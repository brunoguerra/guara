class Guara::Jobs::ProfessionalFormation < ActiveRecord::Base
    attr_accessible :formation_id, :professional_id

    belongs_to :professional
    belongs_to :formation
    
end
