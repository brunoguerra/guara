# encoding: utf-8
require 'active_extend/string_helper.rb'

module Guara
  module BaseHelper
    include StringHelper
    
    # Returns the full title on a per-page basis.
    def full_title(page_title)
      # trans
      base_title = I18n.t("crm.title.full")
      
      #insert sep
      page_title = "| "+page_title if !page_title.empty?
      #results
      "#{base_title} | #{page_title}"
    end
    
    def title()
      I18n.t("crm.title.small")
    end
    
    def pluralize_without_count(count, noun, text = nil)
      if count != 0
        count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
      end
    end
    
    def puts_on_file(file, string=nil)
      aFile = File.new(file, "w")
      aFile.write(string || yield)
      aFile.close
    end
    
    def class_exists?(class_name)
      return Object.const_defined? (class_name)
    rescue Exception => e
      return false
    end
  end
end