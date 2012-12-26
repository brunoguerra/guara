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
  
  end
end