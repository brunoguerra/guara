module Guara
  module ActiveCrm
    class ScheduledReportController < Guara::BaseController

      def index
        authorize! :read, Guara::ActiveCrm::Scheduled 
        params[:search] = {} if params[:search].nil?
        if params[:search].size>0
          @scheduleds = Guara::ActiveCrm::Scheduled.joins(:groups => [:deals => :contacts]).uniq.search(params[:search])
        else
          @scheduleds = []
        end
      end
    
      def print
      end
    end
  end
end
