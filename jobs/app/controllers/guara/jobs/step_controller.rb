
module Guara
  module Jobs
    class StepController < Guara::BaseController
      skip_authorization_check

      def index
        
      end

      def destroy
        @step = Step.find(params[:id])
        @step.destroy
        respond_to do |format|
          format.json { render :json => {:sucess=> true} }
        end
      end
      
      def create
        @step = Step.new
        @step.attributes = params[:step]

        respond_to do |format|
          if @step.save
            format.json { render :json => @step, :status => :created }
          else
            format.json { render :json => @step.errors, :status => :unprocessable_entity }
          end
        end
      end   
    end
  end
end

