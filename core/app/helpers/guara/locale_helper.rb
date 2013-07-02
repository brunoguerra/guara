module Guara
  module LocaleHelper
  
  	def format_datetime(datetime, format = "%d/%m/%Y %H:%m")
      return nil if datetime.nil?
  	  if datetime.instance_of? String
  	    datetime = Time.parse datetime
      end
    
  		datetime.strftime(format) unless datetime==nil
  	end
	
  	def format_date(date, format="%d/%m/%Y")
      return nil if date.nil?
  	  if date.instance_of? String
  	    begin
  	    date = Time.parse date
        rescue
          date = ''
          return date
        end
      end
    
  	  date.strftime(format) unless date==nil
    end

    def format_time(time, format = "%H:%m")
      return nil if time.nil?
      if datetime.instance_of? String
        datetime = Time.parse datetime
      end
    
      datetime.strftime(format) unless datetime==nil
    end
  
  end
end