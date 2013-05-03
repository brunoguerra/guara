
module Guara
  module Jobs
    class VacancyStatus
      
      attr_accessor :id, :name, :parent, :routes
      
      @@opened   = VacancyStatus.new(id: 1, name: "opened")
      @@paused   = VacancyStatus.new(id: 2, name: "paused")
      @@closed   = VacancyStatus.new(id: 3, name: "opened")

      @@canceled            = VacancyStatus.new(id: 4, name: "canceled",     parent: @@closed)
      @@closed_total        = VacancyStatus.new(id: 5, name: "closed total", parent: @@closed)
      @@closed_partial      = VacancyStatus.new(id: 6, name: "closed total", parent: @@closed)
      @@reopened_reposition = VacancyStatus.new(id: 7, name: "reopened",     parent: @@opened)
      @@reopened_others     = VacancyStatus.new(id: 8, name: "reopened",     parent: @@opened)
      
      @@opened.routes                   = [@@paused, @@closed_total, @@closed_partial, @@canceled]
      @@paused.routes                   = [@@reopened_others, @@reopened_reposition, @@canceled] 
      @@canceled.routes                 = [@@reopened_others, @@reopened_reposition]
      @@closed.routes                   = [@@reopened_others, @@reopened_reposition] 
      @@closed_total.routes             = @@closed.routes
      @@closed_partial.routes           = @@closed.routes
      @@reopened_reposition.routes      = @@opened.routes
      @@reopened_others.routes          = @@opened.routes
      
    	def self.enum
    		{
    			1 => @@opened,
    			2 => @@paused,
    			3 => @@closed,
    			4 => @@canceled,
    			5 => @@closed_total,
    			6 => @@closed_partial,
    			7 => @@reopened_reposition,
    			8 => @@reopened_others    			
    		}
    	end
    end
  end
end