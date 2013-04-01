module Guara
  module EmailHelper
  
    def concat_emails(emails, separator = ", ")
      ret = emails.map {|e| e.email.gsub(/;/, '<br />') }.join(separator).html_safe unless emails.nil?
    end
  
  end
end