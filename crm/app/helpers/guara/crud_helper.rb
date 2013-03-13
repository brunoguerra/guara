module Guara
  module CrudHelper
  	def index_btn_view(path, title="")

  		link_to raw('<i  class="icon-search"></i>'), path, :class => "btn ", :title => title
  		
  	end

  	def index_btn_edit(path, title="")

  		link_to raw('<i  class="icon-pencil"></i>'), path, :class => "btn ", :title => title
  		
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

  end
end