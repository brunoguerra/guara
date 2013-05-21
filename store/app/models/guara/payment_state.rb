
module Guara
  class PaymentState
    
    def self.state
		{
			:WAITING 	=> 1,
			:ANALYZING  => 2,
			:CONFIRMED 	=> 3
		}
	end

	def self.state_translated
		{
			1 => I18n.t("waiting"),
			2 => I18n.t("analyzing"),
			3 => I18n.t("confirmed")
		}
	end
    
  end
end