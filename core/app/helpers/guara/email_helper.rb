module Guara
  module EmailHelper
  
    def concat_emails(emails)
      emails.map {|e| e.email }.join(", ") unless emails.nil?
    end
  
  end
end