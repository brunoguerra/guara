
module Guara
  module Jobs
    class ProcessInstanceController < Guara::BaseController
      load_and_authorize_resource :process_instance, :class => "Guara::Jobs::ProcessInstance"
      load_and_authorize_resource :custom_process, :class => "Guara::Jobs::CustomProcess"


      helper CrudHelper

      def index
        @search = ProcessInstance.search(params[:search])
        if class_exists?("Ransack")
            @process_instance = @search.result().paginate(page: params[:page], :per_page => 10)
        else
            @process_instance = @search.paginate(page: params[:page], :per_page => 10)
        end
        params[:search] = {} if params[:search].nil?
        
        if @process_instance.size == 0
          @custom_process = CustomProcess.first 
        else  
          @custom_process = @process_instance.first
        end
      end

      def new
        @custom_process = CustomProcess.find(params[:process_id])
        @process_instance = ProcessInstance.new 
        
        @process_instance.update_attributes({
          :process_id=> params[:process_id],
          :date_start=> Time.now.to_s(:db),
          :user_using_process=> current_user.id,
          :state=> @custom_process.step_init
        })

        if @process_instance.save
          redirect_to edit_process_instance_path(@process_instance)
        else
          render :index
        end
      end

      def alter_state_process_instance
        @process_instance = ProcessInstance.find params[:id]
        @process_instance.update_attributes :state=> params[:state]
        @process_instance.save

        redirect_to edit_process_instance_path(params[:id])
      end

      def edit
        @process_instance = ProcessInstance.find params[:id]
        
        if params[:edit_step].nil?
          @current_step = @process_instance.step
        else
          @current_step = Step.find params[:edit_step]
        end
        
        get_step_init_and_steps_order_and_step_resume(@process_instance, true, false, true)
        @columns = set_columns(@step_attrs)
        @vals      = attrValues(@step_attrs, @step_init.step_attrs_vals(params[:id]))
        @current_step_attrs = @current_step.step_attrs
        @vals_edit = attrValues(@current_step_attrs, @current_step.step_attrs_vals(params[:id]))
        @current_columns = set_columns(@current_step_attrs)        
      end

      def get_step_attr_cache(step_attr_id)
        @current_step_attrs.each do |a|
          return a if a.id == step_attr_id
        end
      end

      def attrValues(step_attrs, step_instance_attrs)
        @attr_vals = {}
        step_attrs.each do |s|
          @attr_vals[s.id] = ""
        end

        step_instance_attrs.each do |a|
          if a.value.nil?
            @temp = []
            a.step_instance_attr_multis.each do |s|
              @temp << { :value=> s.value, :step_attr_option=> get_step_attr_cache(a.step_attr_id).options }
            end
            @attr_vals[a.step_attr_id] = @temp

          else
            @attr_vals[a.step_attr_id] = a.value
          end  
        end

        return @attr_vals
      end

      def update
        @a = params[:step_instance_attrs]
        @step_id = @a.delete(:step_id)
        StepInstanceAttr.delete_all("step_id = #{@step_id}")
        
        @a.each do |k,v|
          @atr = {:process_instance_id=> params[:id], :step_attr_id=> k, :step_id=>@step_id, :value=> nil}
          if v.class == Array
            @step_instance_attr = StepInstanceAttr.create(@atr)
            v.each do |a|
              @step_instance_attr.step_instance_attr_multis.create :value=> a
            end
          else
            @atr[:value] = v
            @step_instance_attr = StepInstanceAttr.create(@atr)
          end
        end  

        @process_instance = ProcessInstance.find params[:id]
        @next_step = @process_instance.step.next
        if @next_step.nil?
          @process_instance.update_attributes :date_finish=> Time.now.to_s(:db)
          @process_instance.save
          redirect_to process_instance_index_path
        else
          @process_instance.update_attributes :state=> @next_step
          @process_instance.save
          redirect_to edit_process_instance_path(params[:id])
        end    
      end

      def show_step
        edit
      end
      
      def show
        @process_instance = ProcessInstance.find params[:id]
        get_step_init_and_steps_order_and_step_resume(@process_instance, true, true, true)
        @columns = set_columns(@step_attrs)
        @vals = attrValues(@step_attrs, @step_init.step_attrs_vals(params[:id]))
        
      end

      def set_columns(steps_attrs)
        @set_columns = {}
        steps_attrs.each do |s|
          @set_columns[s.column] = [] if @set_columns[s.column].nil?
          @set_columns[s.column] << s
        end

        return @set_columns
      end

      def get_step_init_and_steps_order_and_step_resume(process_instance, step_init=false, step_order=false, step_attrs=false)
        @step_init  = process_instance.step_init if step_init == true
        @step_order = process_instance.steps_previous_current if step_order == true
        @step_attrs = @step_init.step_attrs_resume if step_attrs == true
      end
    
    end
  end
end

