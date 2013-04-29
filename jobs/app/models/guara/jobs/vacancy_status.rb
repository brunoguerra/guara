
module Guara
  module Jobs
    class VacancyStatus
      
      attr_accessor :id, :name, :parent, :routers
      
      @@opened   = VacancyStatus.new(id: 1, status: "opened")
      @@paused   = VacancyStatus.new(id: 2, status: "paused")
      @@closed   = VacancyStatus.new(id: 3, status: "opened")

      @@canceled            = VacancyStatus.new(id: 4, status: "canceled", parent: @@closed)
      @@closed_total        = VacancyStatus.new(id: 5, status: "closed total", parent: @@closed)
      @@closed_partial      = VacancyStatus.new(id: 6, status: "closed total", parent: @@closed)
      @@reopened_reposition = VacancyStatus.new(id: 7, status: "reopened", parent: @@opened)
      @@reopened_others     = VacancyStatus.new(id: 8, status: "reopened", parent: @@opened)
      
      @@opened.routers                   = [@@paused, @@closed_total, @@closed_partial, @@canceled]
      @@paused.routers                   = [@@reopened_others, @@reopened_reposition, @@canceled] 
      @@canceled.routers                 = [@@reopened_others, @@reopened_reposition]
      @@closed.routers                   = [@@reopened_others, @@reopened_reposition] 
      @@closed_total.routers             = @@closed.routers
      @@closed_partial.routers           = @@closed.routers
      @@reopened_reposition.routers      = @@opened.routers
      @@reopened_others.routers          = @@opened.routers
      
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