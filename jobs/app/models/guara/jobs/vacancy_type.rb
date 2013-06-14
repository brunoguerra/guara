module Guara
	module Jobs
  		class VacancyType
  			
  			attr_accessor :id, :name

  			def initialize(options = {})
  				self.id = options[:id]
  				self.name = options[:name]
  			end

  			def self.type
  				{
  					0 => :effective,
  					1 => :temporary,
  					2 => :professional_person,
  					3 => :judicial_persons,
  					4 => :trainee
  				}
  			end

  			def self.type_translated
  				{
  					0 => I18n.t("jobs.vacancy_type.effective"),
  					1 => I18n.t("jobs.vacancy_type.temporary"),
  					2 => I18n.t("jobs.vacancy_type.professional_person"),
  					3 => I18n.t("jobs.vacancy_type.judicial_persons"),
  					4 => I18n.t("jobs.vacancy_type.trainee")
  				}
  			end

  			def self.all 
  				result = []
  				type_translated.each do |key, value|
  					result << VacancyType.new(id: key, name: value)
  				end
  				result
  			end

   		end
  	end
  end
