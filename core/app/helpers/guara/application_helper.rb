# encoding: utf-8
require 'active_extend/string_helper.rb'

module Guara
  module ApplicationHelper
  
    include StringHelper
  
    # Returns the full title on a per-page basis.
      def full_title(page_title)
        base_title = I18n.t("crm.title.full")
        if page_title.empty?
          base_title
        else
          "#{base_title} | #{page_title}"
        end
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
  end
end