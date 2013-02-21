module Guara
  module CustomersHelper
  
    def customers_invalids
      #TODO: customers_invalids
      Customer.where(:complete => nil).count
    end
  
    def birthdays
      #TODO: birthdays
      0
    end
  
    def navbar_title
      nil
    end
  
    def index_notes(notes)
      if notes.to_s.size>140
        notes[0..139].concat("...")
      end
    end

    def customer_nav_modules_build_tabs(customer, active)

      res = ""

      puts Guara::Customer.modules.inspect

      Guara::Customer.modules.each do |md| 
        md[:tabs].each do |tab|
          res = "<li "
          res += 'class=active' if active == tab[:name]
          res += ">"
          res += link_to tab[:title], tab[:url].call(customer)
          res += "</li>"

       end
      end

      raw res
    end
  
  end
end