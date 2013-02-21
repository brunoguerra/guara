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
    
    
    def build_menu_items(menu)
      returns = ""
      menu[:items].each do |item|
        rails_model = item.to_s.titlecase.gsub(' ','').singularize.to_sym
        
        if can? :read, rails_model
        
          if (item.is_a? Array)
            item_title = item[0]
            path = eval item[1]
          else
            item_title = item
            menu_path = []
            menu_path << menu[:prefix] if !menu[:prefix].nil? && !menu[:prefix].empty?
            menu_path << item
            menu_path << "path"
            path = eval(menu_path.join('_')+"()")
    			end
           			
    			returns += %Q{ <li>#{ link_to t(item_title.to_s+".title"), path }</li> }

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