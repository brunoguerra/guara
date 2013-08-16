#encoding: utf-8
module Guara
  module ActiveCrm  
  begin
    
    ::Guara::SystemModule.create([
                   { name: 'Guara::ActiveCrm::Scheduler' },
                   { name: 'Guara::ActiveCrm::Scheduled' },
                   { name: 'Guara::ActiveCrm::Scheduled::Contact' },
                   { name: 'Guara::ActiveCrm::Scheduled::CustomerGroup' },
                   { name: 'Guara::ActiveCrm::Scheduled::Deal' },
                  ])
      
  	rescue Exception => exception
  	    logger =  Logger.new(STDOUT)
  	    if exception.respond_to?(:record) && !exception.record.nil?
  	      logger.error("Error running task db:seed - #{exception.message} #{exception.class} #{exception.record.to_yaml}\n#{exception.record.errors.to_yaml}\n\n")
  	    else
  	      logger.error("Error running task db:seed - #{exception.message} #{exception.class}\n\n")
  	    end
  	    logger.info exception.backtrace.to_yaml
  	end
  end
  
end