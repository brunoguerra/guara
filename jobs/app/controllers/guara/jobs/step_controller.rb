
module Guara
  module Jobs
    class StepController < Guara::BaseController
      skip_authorization_check

      def index
        
      end
      
      def create
        @step = Step.new
        @step.attributes = params[:step]

        if @step.save
          render :json => @step, :status => :created, :location => @step
        else
          render :json => @step.errors, :status => :unprocessable_entity
        end
      end   
    end
  end
end

