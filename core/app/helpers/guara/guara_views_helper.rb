module Guara
  module GuaraViewsHelper
  
    def format_boolean(value)
      value ? t("commons.yes"):t("commons.no")
    end
  
    def yes_or_no(value)
      value ? t("commons.yes"):t("commons.no")
    end
    ##
    #
    # options
    #   - add_class format add button
    # 
    def link_to_add_fields(name, f, association, options = {})
      options ||= {}
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.semantic_fields_for(association, new_object, child_index: id) do |builder|
        #render(association.to_s + "/" + association.to_s.singularize + "_fields", f: builder)
        yield builder
      end
      link_to(t("helpers.forms.#{name}"), '#', class: "add_fields " + options[:add_class].to_s , data: {id: id, fields: fields.gsub("\n", "")})
    end
  
    def nbsp(value)
      if value.nil? || ((value.kind_of? String) &&  value.empty?)
        raw "&nbsp;"
      else
        value
      end
    end
  
    def show_label_tag(label)
      label_tag label, label+":", :class => "strong"
    end
  
    def inline_namedlist(list)
       list.all.collect {|item| "#{item.name}" }.join ", "
    end
  
    def inline_list(list, field=nil)
      field = "name" if field.nil?
      list.all.collect {|item| (item.send field.to_sym).to_s }.join ", "
    end
  
  end
end