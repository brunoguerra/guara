
module Guara
  module FormAjaxHelper
  
    def format_errors(plural_model_name, errors)
      Hash[errors.map { |k,v| [ I18n.translate("%s.%s" % [plural_model_name, k]), v ] }]
    end
  
  end
end