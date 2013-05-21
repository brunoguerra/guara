
module Guara
  class OrderState
    
    def self.status
		{
			:BUDGET 	=> 1,
			:CONFIRMED 	=> 2,
			:PAID 		=> 3,
			:FINALIZED 	=> 4
		}
	end

	def self.status_translated
		{
			1 => I18n.t("budget"),
			2 => I18n.t("confirmed"),
			3 => I18n.t("paid"),
			4 => I18n.t("finalized")
		}
	end
    
  end
end