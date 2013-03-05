require File.expand_path("../../jobs", __FILE__) if Rails.env.development?


class Guara::Jobs::LevelAvaliation < ActiveRecord::Base
	
	def self.levels
		{
			0 => :bad,
			1 => :regular,
			2 => :good,
			3 => :great
		}
	end

	def self.levels_translated
		{
			0 => I18n.t("jobs.level_avaliation.bad"),
			1 => I18n.t("jobs.level_avaliation.regular"),
			2 => I18n.t("jobs.level_avaliation.good"),
			3 => I18n.t("jobs.level_avaliation.great")
		}
	end
	  	
end

