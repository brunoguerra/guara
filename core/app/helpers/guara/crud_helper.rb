module Guara
  module CrudHelper
  	def index_btn_view(path, title="")
  		link_to raw('<i  class="icon-search"></i>'), path, :class => "btn ", :title => title
  	end

  	def index_btn_edit(path, title="")
  		link_to raw('<i  class="icon-pencil"></i>'), path, :class => "btn ", :title => title
  	end
  	
  	def index_btn_disable(path, title="")
  		link_to raw('<i  class="icon-minus-sign"></i>'), path, :class => "btn ", :title => title, :confirm => I18n.t("helpers.forms.areyousure"), :method => :delete
  	end

    def index_btn_select(path, options = {})
      options[:class] = "btn btn-info" if options[:class].nil? 
      
      link_to raw('<i  class="icon-ok"></i>'), path, options
    end


    def show_label_tag(label)
      label_tag label, label+":", :class => "strong"
    end

    def build_empty_many_relation(relation)
      relation.build if relation.size==0
    end

    def build_empty_one_relation(object, relation_sym)
      if (not object.nil?) && object.send(relation_sym).nil?
        object.send("build_#{relation_sym.to_s}".to_sym)
      end
    end
    
    def order_asc_icon(asc=true)
      if asc
        '<i class="icon-chevron-up"></i>'.html_safe
      else
        '<i class="icon-chevron-down"></i>'.html_safe
      end
    end


    def select_ajax_tag(name, url, options_to_select = {}, options={})
      options[:'data-json-url'] = url
      options[:class] = options[:class].to_s + ' multiselect'
      select_tag name, options_to_select, options
    end

  end
end