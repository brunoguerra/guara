
module Guara
  module Jobs
    class ProcessInstanceController < Guara::BaseController
      load_and_authorize_resource :process_instance, :class => "Guara::Jobs::ProcessInstance", 
        :except => [ 
          :alter_state_process_instance,
          :load_grouped_columned_attrs,
          :create_step_instance_attrs,
          :load_next_step_to_process_instance,
          :set_next_step_to_process_instance,
          :finish_process_instance,
          :show_step,
          :embeded_call,
          :multiselect_customer_pj
        ]

      helper CrudHelper

      attr_accessor :embedded

      def index
        params[:search] = {:finished_is_false=> true} if params[:search].nil?
        params[:search][:finished_is_false] = true if params[:search][:finished_is_true] == '0'

        @search = ProcessInstance.joins(:custom_process).where(:guara_jobs_custom_processes=> {:name=> 'vacancy'})
        .order('id DESC').search(params[:search])
        @process_instance = paginate(@search, params[:page], 10)
        
        authorize! :read, @custom_process
      end

      def new
        @custom_process = Vacancy.custom_process
        @process_instance = ProcessInstance.new({
          :process_id=> @custom_process.id,
          :date_start=> Time.now.to_s(:db),
          :finished=> false,
          :user_using_process=> current_user.id,
          :state=> @custom_process.step_init
        })

        load_step_and_step_attrs
        
        authorize! :read, @custom_process
      end

      def create
        @process_instance = ProcessInstance.new(params[:step_instance_attrs][:process_instance])
        if @process_instance.save
          params[:step_instance_attrs].delete(:process_instance)
          params[:id] = @process_instance.id
          update
        else
          redirect_to new_process_instance_path(process_id: params[:process_instance][:process_id])
        end
      end

      def alter_state_process_instance
        @process_instance = ProcessInstance.find params[:id]
        @process_instance.update_attributes :state=> params[:state]
        @process_instance.save

        redirect_to edit_process_instance_path(params[:id])
        authorize! :update, Guara::Jobs::ProcessInstance
      end

      def edit
        authorize! :read, @custom_process

        @process_instance = ProcessInstance.find params[:id]
        
        load_step_and_step_attrs

        if @embedded
          render :partial => "guara/jobs/process_instance/form"
        else

        end
      end

      def load_step_and_step_attrs
        if params[:edit_step].nil?
          @current_step = @process_instance.step
          params[:edit_step] = @current_step.id
        else
          @current_step = Step.find params[:edit_step]
        end

        @grouped_column_attrs_current_step = load_grouped_columned_attrs(@current_step)
        @grouped_column_attrs_step_init    = load_grouped_columned_attrs(@process_instance.custom_process.step, true)
      end
      
      def load_grouped_columned_attrs(step, reject_resume_false=false)
        if reject_resume_false
          grouped_attrs = step.attrs.where(:resume=>true).order(:position).group_by(&:group)
        else
          grouped_attrs = step.attrs.order(:position).group_by(&:group)
        end
        
        grouped_column_attrs = {}
        
        grouped_attrs.each do |group, attrs|
          grouped_column_attrs[group] = attrs.group_by(&:column)
        end
        
        if grouped_column_attrs.include? ''
          grouped_column_attrs[:default] = grouped_column_attrs['']
          grouped_column_attrs.delete('')
        end

        authorize! :read, Guara::Jobs::StepInstance
        return grouped_column_attrs
      end

      def create_step_instance_attrs
        attrs = []
        @step_instance_attrs.each do |key, value|
          step_attr_val = {
            :process_instance_id=> params[:id], 
            :step_attr_id=> key, 
            :step_id=>@step_id, 
            :value=> nil
          }

          if value.class == Array
            @step_instance_attr = StepInstanceAttr.create(step_attr_val)
            value.each do |attr|
              @step_instance_attr.step_instance_attr_multis.create :value=> attr
            end
          else
            step_attr_val[:value] = value
            @step_instance_attr = StepInstanceAttr.create(step_attr_val)
          end
          attrs << @step_instance_attr
        end

        if @process_instance.custom_process.has_hook? && @process_instance.custom_process.hook.respond_to?(:step_instance_after_save)
          @step = Step.find @step_id
          @process_instance.custom_process.hook.step_instance_after_save(attrs, @process_instance, @step)
        end

        authorize! :create, Guara::Jobs::StepInstance
      end

      def update
        @process_instance = ProcessInstance.find params[:id]
        @step_instance_attrs = params[:step_instance_attrs]
        @step_id = @step_instance_attrs.delete(:step_id)

        StepInstanceAttr.delete_all("step_id = #{@step_id} AND process_instance_id = #{params[:id]}")

        create_step_instance_attrs()
        set_next_step_to_process_instance()

        if !@embedded
          redirect_to process_instance_show_step_path(:id=> params[:id], :edit_step=> @step_id)
        end  
      end

      def load_next_step_to_process_instance()
        @process_instance = ProcessInstance.find params[:id]
        @next_step = @process_instance.step.next
        step_attr_count = StepAttr.where(:step_id=> @next_step).count()
        step = Step.find(@step_id)

        if step_attr_count > 0 and step.level == @process_instance.step.level
          @next_step_valid = 1
        else
          @next_step_valid = 0
        end
        authorize! :read, Guara::Jobs::ProcessInstance
      end

      def set_next_step_to_process_instance()
        load_next_step_to_process_instance()

        if !@next_step.nil? and @next_step_valid > 0
          @process_instance.update_attributes :state=> @next_step
          @process_instance.save
        end 
        authorize! :update, Guara::Jobs::ProcessInstance
      end

      def finish_process_instance
        @process_instance = ProcessInstance.find params[:process_instance_id]
        @process_instance.update_attributes :date_finish=> Time.now.to_s(:db), :finished=> true
        @process_instance.save

        redirect_to process_instance_index_path

        authorize! :update, Guara::Jobs::ProcessInstance
      end

      def show_step
        edit
        authorize! :read, Guara::Jobs::StepInstance
        authorize! :read, @custom_process
      end
      
      def show
        @process_instance = ProcessInstance.find params[:id]
        @grouped_column_attrs_step_init = load_grouped_columned_attrs(@process_instance.custom_process.step)
        @grouped_column_attrs_current_step = load_grouped_columned_attrs(@process_instance.step)
        @step_order = @process_instance.steps_previous_current
        
        load_step_valid()
        authorize! :read, @custom_process

        if @embedded
          render :partial => "guara/jobs/process_instance/details_current_stage"
        else
          render
        end
      end

      def load_step_valid
        @step_previous = @process_instance.step
        @step_values_invalid = @process_instance.step.step_attrs_vals(@process_instance.id).empty?

        if @step_values_invalid
          @step_order.each do |step|
            if step.next == @process_instance.step.id
              @step_previous = step 
            end
          end
        end
      end
      
      def embeded_call(action, process_instance, params, request, response)
        params = params.dup
        params[:id] = process_instance.id
        params[:action] = action
        params[:process_instance] = nil
        params[:edit_step] = nil

        self.params = params
        self.request = request
        self.response = response

        self.embedded = true

        authorize! :read, Guara::Jobs::ProcessInstance

        return self.send(action)
      end

      def multiselect_customer_pj
        render :json => CustomerPj.includes(:person).where(["(guara_people.name ilike ? or guara_people.name_sec ilike ?)", params[:search]+"%", params[:search]+"%"] ).limit(25).collect { |c| { :id => c.id.to_s, :name => c.person.name } }
        authorize! :read, Guara::Jobs::ProcessInstance
      end
    end
  end
end

