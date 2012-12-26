
module Guara
  module UserAbilitiesHelper

    def abilities_name_checkbox(module_, ability)
      "module[%d][%d]" % [module_.id, ability.id]
    end

    def abilities_id_checkbox(module_, ability)
      "module_%d_%d" % [module_.id, ability.id]    
    end

  end
end