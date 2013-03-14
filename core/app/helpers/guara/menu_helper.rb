module Guara
  module MenuHelper
  
    ##
    # build menu to site 
    # @param menu title items
    #
    def build_menu(menu)
      raw %Q{
        <li id="fat-menu" class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            #{t(menu[:title]+".link")} <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            #{build_menu_items(menu)}
          </ul>
        </li>
          }
    end
    
    
    def get_path_from_sym(sym, prefix)
      item_title = sym
      menu_path = []
      menu_path << prefix if !prefix.nil? && !prefix.empty?
      menu_path << sym
      menu_path << "path"
      eval(menu_path.join('_')+"()")
    end
    
    def build_menu_items(menu)
      returns = ""
      menu[:items].each do |item|
        
        if item.is_a? Symbol
          rails_model = item.to_s.titlecase.gsub(' ','').singularize.to_sym
          item_name = rails_model
          path = get_path_from_sym(item, menu[:prefix])
        elsif item.is_a? Hash
          item_name = item[:name]
          rails_model = item[:resource]
          path = item[:path].nil? ? get_path_from_sym(item[:name], menu[:prefix]) : item[:path]
        elsif item.is_a? Array
          rails_model = item[0]
          item_name = rails_model
          path = eval item[1]
        end
        
        if can? :read, rails_model
    			returns += %Q{ <li>#{ link_to t(item_name.to_s+".title"), path }</li> }
        end
      end
      returns
    end
  
    def build_menu_maintence()
      build_menu(Guara::Menus::MAINTENCE)
    end
  
    def build_menu_admin()
      build_menu(Guara::Menus::ADMINISTRATION)
    end
    
    def build_menu_modules()
      res = ""
      Guara::Menus::MODULES.each do |menu_name, menu|
        res += build_menu(menu)
      end
      raw res
    end
  
  end
end