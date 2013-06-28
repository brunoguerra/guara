module Guara
	module Jobs
  		class ProfileUpdatedAt < ActiveRecord::Base
    		
    		def self.updated_translated
    			{
					Time.now.months_ago(6) => I18n.t("jobs.profile_updated_at.six_months"),
					Time.now.months_ago(12) => I18n.t("jobs.profile_updated_at.one_year"),
					Time.now.months_ago(18) => I18n.t("jobs.profile_updated_at.one_year_and_six_months"),
					Time.now.months_ago(24) => I18n.t("jobs.profile_updated_at.two_years")
				}
    		end

    	end
  	end
end
