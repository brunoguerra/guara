
module Guara
  module FormAjaxHelper
  
    def format_errors(plural_model_name, errors)
      Hash[errors.map { |k,v| [ I18n.translate("%s.%s" % [plural_model_name, k]), v ] }]
    end
    
    def form_ajax(name, form_html, function_callback)
      r = form_html.to_s
      r.gsub!(/<form/, "<div id='form_ajax_#{name.to_s}'")
      r.gsub!(/<\/form/, '</div')
      r.gsub!(/type="submit"/, "type='button' id='form_ajax_#{name.to_s}_submit'")
      r += form_ajax_script(name, function_callback)
      return raw r
    end
    
    def form_ajax_script(name, javascript_callback)
      file_script = File.read(File.expand_path("../../../assets/javascripts/guara/form_ajax_transform.js", __FILE__))
      file_script.gsub!(/form_ajax_name/, "form_ajax_#{name}")
      file_script.gsub!(/ajax_form_funcion_callback/, "#{javascript_callback}")
      "<script>#{file_script}</script>"
    end
  
  end
end