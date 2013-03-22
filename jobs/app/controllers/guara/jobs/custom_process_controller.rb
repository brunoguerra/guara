# encoding: UTF-8
module Guara
  module Jobs
    class CustomProcessController < Guara::BaseController

      skip_authorization_check

      helper CrudHelper

      def index
        @custom_process = CustomProcess.find(:all, :conditions=> ['source_id IS NULL'])
      end

      def show
        if params[:released].nil?
          @custom_process = CustomProcess.find(params[:id]).get_released
        else
          @custom_process = CustomProcess.find(params[:released])
        end

        @steps = Step.find(:all, :conditions => ["custom_process_id = ?", @custom_process.id])
        @jsonNext = [{:id=>'process', :next=> @custom_process.step_init, :attrs=> []}]
        get_all_next_steps(@custom_process.step_init)

        if !session[:button_edit_process].nil? && session[:button_edit_process] == true
          @button_enable = true 
          session[:button_edit_process] = false
        else
          @button_enable = false
        end 
      end

      def new
        @custom_process = CustomProcess.new
      end

      def create
        @custom_process = CustomProcess.new
        params[:jobs_custom_process][:hook_instanciate] = 'Guara::Jobs::VacancyProcessHook'
        @custom_process.attributes = params[:jobs_custom_process]

        if @custom_process.save
          flash[:success] = t("helpers.forms.new_sucess")
          redirect_to custom_proces_path(@custom_process)
        else
          render :new
        end
      end

      def remove_protected_attrs(obj)
        obj.delete('id')
        obj.delete('created_at')
        obj.delete('updated_at')
        return obj
      end

      def load_custom_process_released
        if params[:released].nil?
          @custom_process = CustomProcess.find(params[:id]).get_released
        else
          @custom_process = CustomProcess.find(params[:released])
        end
      end

      def create_release_custom_process
        CustomProcess.update_all("released = FALSE", "source_id = #{params[:id_root]}")
        source_id = @custom_process.source_id.nil? ? @custom_process.id : @custom_process.source_id
        obj = @custom_process.attributes.merge({:released=> true, :source_id=> source_id})
        custom_process_attrs = remove_protected_attrs(obj)
        @new_custom_process = CustomProcess.create custom_process_attrs
      end

      def create_release_step(step)
        step_attrs = remove_protected_attrs(step.attributes.merge({ :custom_process_id=> @new_custom_process.id, :next=>@new_step[:id] }))
        @new_step = Step.create step_attrs

        if step.level == 0
          @new_custom_process.update_attributes({:step_init=> @new_step.id})
        end
      end

      def create_release_step_attr(step)
        step.attrs.each do |attrs|
          attr_attrs = remove_protected_attrs(attrs.attributes.merge({ :step_id=> @new_step.id }))
          new_attr = StepAttr.create attr_attrs
        end
      end

      def set_release
        load_custom_process_released()
        create_release_custom_process()        
        
        @new_step = {}
        @custom_process.steps.order('level DESC').each do |step|
          create_release_step(step)
          create_release_step_attr(step)
        end

        session[:button_edit_process] = true
        render :json => {:success=> true, :custom_process_id=> @new_custom_process.id}
      end

      def set_enabled_custom_process
        @custom_process = CustomProcess.find(params[:id])
        if !@custom_process.source_id.nil?
          if !@custom_process.released == true
            @custom_process.update_attributes({:enabled=> (@custom_process.enabled == true ? false : true )})
            @custom_process.save
            flash[:success] = "CustomProcess Alterado!"
          else
            flash[:error] = "Não pode alterar por ser CustomProcess Atual"
          end
        else 
          flash[:error] = "Não pode alterar o CustomProcess Inicial"
        end

        redirect_to custom_proces_path((@custom_process.source_id.nil? ? @custom_process.id : @custom_process.source_id))
      end

      def custom_process_steps
        @custom_process = CustomProcess.find params[:custom_process][:custom_process_id]
        @json = JSON.parse(params[:custom_process][:json])
        
        if @custom_process.update_attributes({:step_init=> @json[0]['id']})
          save_next_steps(@json[0], @json[0]['sons'])
          render :json => {:success=> true}
          session[:button_edit_process] = true
        else
          render :json => {:success=> false}
        end
      end

      def get_all_next_steps(id)
        @attrs = []
        @steps.each do |s|
          if s.id == id
            s.attrs.order(:position).each do |a|
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
