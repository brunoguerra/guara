
module Guara
  module Jobs
    class CustomProcessController < Guara::BaseController

      skip_authorization_check

      helper CrudHelper

      def index
        @custom_process = CustomProcess.all
      end

      def show
        @custom_process = CustomProcess.find params[:id]
        @steps = Step.find(:all, :conditions => ["custom_process_id = ?", params[:id]])
        @jsonNext = [{:id=>'process', :next=> @custom_process.step_init, :attrs=> []}]
        get_all_next_steps(@custom_process.step_init)
      end

      def new
        @custom_process = CustomProcess.new
      end

      def create
        @custom_process = CustomProcess.new
          @custom_process.attributes = params[:jobs_custom_process]

          if @custom_process.save
            flash[:success] = t("helpers.forms.new_sucess")
            redirect_to custom_proces_path(@custom_process)
          else
            render :new
          end
      end

      def custom_process_steps
        @custom_process = CustomProcess.find params[:custom_process][:custom_process_id]
        @json = JSON.parse(params[:custom_process][:json])
        
        if @custom_process.update_attributes({:step_init=> @json[0]['id']})
          save_next_steps(@json[0], @json[0]['sons'])
          render :json => {:success=> true}
        else
          render :json => {:success=> false}
        end
      end

      def get_all_next_steps(id)
        @attrs = []
        @steps.each do |s|
          if s.id == id
            s.step_attrs.each do |a|
              @attrs << a
            end

            @jsonNext << {
              :id=>s.id, 
              :next=> s.next, 
              :attrs=> @attrs, 
              :attrs_size=> @attrs.size
            }
            
            if s.next != nil
              get_all_next_steps(s.next)
            end
          end
        end
      end

      def save_next_steps(json, sons)
        @steps = Step.find json['id']
        @steps.update_attributes({:level=> json['level']})

        sons.each do |a|
          if a.size > 0
            @steps = Step.find a['source_id']
            @steps.update_attributes({:next=> a['id']})
            save_next_steps(a, a['sons'])
          end
        end
      end

      def add_attr_to_steps
        @json = JSON.parse(params[:elements])
        StepAttr.destroy_all(:step_id=> params[:step_id])
        @attrs = []
        @i = -1;
        @json.each do |j|
          @i += 1
          j['step_id'] = params[:step_id]
          @attr = StepAttr.create(j)
          j['id'] = @i
          @attrs << j
        end
        
        render :json => {:success=> true, :attrs=> @attrs}
      end

      def delete_step
        Step.destroy(params[:step_id])
        render :json => @json
      end
      
    end
  end
end
