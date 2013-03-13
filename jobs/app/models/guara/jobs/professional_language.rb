module Guara
	module Jobs
	  class ProfessionalLanguage < ActiveRecord::Base
	    attr_accessible  :language, :languages_attributes, :language_id, 
	    				 :level_knowledges_attributes, :level_knowledge, :level_knowledge_id,
	    				 :professinal_language_id, :professional_id

	    belongs_to :language
	    belongs_to :level_knowledge

	    accepts_nested_attributes_for :language
	    accepts_nested_attributes_for :level_knowledge

	  end
	end
end
