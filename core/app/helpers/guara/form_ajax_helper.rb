
module Guara
  module FormAjaxHelper
  
    def format_errors(plural_model_name, errors)
      Hash[errors.map { |k,v| [ I18n.translate("%s.%s" % [plural_model_name, k]), v ] }]
    end
    
    def form_ajax(mame, form_html)
      r = form_html.to_s
      r.gsub!(/<form/, '<div id="form_ajax_#{name.to_s}"')
      r.gsub!(/<\/form/, '</div')
      return raw r
    end
  
  end
end