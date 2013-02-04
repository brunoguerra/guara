
module Guara
  module CrudHelper
  	def index_btn_view(path, title="")

  		link_to raw('<i  class="icon-search"></i>'), path, :class => "btn ", :title => title
  		
  	end

  	def index_btn_edit(path, title="")

  		link_to raw('<i  class="icon-envelope"></i>'), path, :class => "btn ", :title => title
  		
  	end


    def show_label_tag(label)
      label_tag label, label+":", :class => "strong"
    end

  end
end