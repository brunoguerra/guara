module Guara
  class CustomerPf < ActiveRecord::Base  
    attr_accessible :gender, :civil_state, :country, :company

    def self.gender
    	{
			0 => :male,
			1 => :female,
		}
	end

	def self.gender_translated
		{
			0 => I18n.t("customer_pfs.male"),
			1 => I18n.t("customer_pfs.female"),
		}
	end

	    def self.civil_state
    	{
			0 => :sigle,
			1 => :married,
			2 => :divorced,
			3 => :widower
		}
	end

	def self.civil_state_translated
		{
			0 => I18n.t("customer_pfs.sigle"),
			1 => I18n.t("customer_pfs.married"),
			2 => I18n.t("customer_pfs.divorced"),
			3 => I18n.t("customer_pfs.widower")
		}
	end


    attr_protected
  
    has_one	:person	, :as => :customer
    has_many	:history_pfs
  
    def prefix
      "pf"
    end
  end
end