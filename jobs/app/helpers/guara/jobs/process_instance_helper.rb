module Guara
    module Jobs
      module ProcessInstanceHelper
        #include Guara::Jobs::ActiveProcess::ProcessStepComponent
      	def get_collection(rec, sels)
      	    
      	    vals = rec.options.dup
            vals2 = vals.dup
            sels = [] if sels.class == String || sels.nil?
            vals.strip!

            if (vals =~ /^\$/) == 0
                model = vals[1..1000].constantize
                if (model.respond_to?(:select_options))
                    options = model.select_options
                elsif @get_ajax_class == "ajax_customer"
                    options = []
                else
                    options = model.all
                end
       		    
                rec.select_opts = options_for_select(options.map { |ff| [ff.name, ff.id] }, (sels || []).collect { |fs| fs[:value] })
            elsif (vals =~ /url:([^\s]*)&/)==0
              rec.html_options = rec.html_options.merge({:"data-json-url" => $1})

              model = eval vals2.scan(/&([^\s]*)/).flatten()[0]
              ids_db = []
              sels.each do |ids|
                ids_db << ids[:value]
              end
              model_options = ids_db.size > 0 ? model.where("id IN (#{ids_db.join(',')})") : []
              rec.select_opts = options_for_select(model_options.map { |ff| [ff.name, ff.id] }, (sels || []).collect { |fs| fs[:value] })
              rec
            elsif (vals =~ /model_eval:\/([^\s]*)\//)==0
                options = eval($1)
                rec.select_opts = options_for_select(options.map { |ff| [ff.name, ff.id] }, (sels || []).collect { |fs| fs[:value] })
            else
                index = -1
                rec.select_opts = options_for_select(vals.split(',').each { |ff| index+=1; [index, ff] }, sels.collect { |fs| fs[:value] })
            end
    	end

        def get_value_model(vals, id)
            vals.strip!
            vals2 = vals.dup
            if !(vals.nil? && vals.empty?)
                if vals[0]=='$'
                    model = vals[1..1000]
                    model = eval model
                    
                    record = model.find id
                    return record.name
                elsif (vals =~ /url:([^\s]*)&/)==0                    
                    model = eval vals2.scan(/&([^\s]*)/).flatten()[0]
                    if model == Guara::CustomerPj
                        record = model.includes(:person).where("id = #{id}").first()
                    else
                        record = model.where("id = #{id}").first()
                    end
                    return record.name
                elsif (vals =~ /model_eval:\/([^\s]*)\//)==0
                    return record = eval($1).where(:id => id).first().name
                else
                    return id
                end    
            else                
                return id
            end
        end

    	def show_label_tag(label)
            label_tag label, label+":", :class => "strong"
        end

        def show_span_tag(text)
        	content_tag :span, text+":", :class => "strong"
        end

        def get_field(form, rec, val)
        	@field = ""
        	if rec.type_field == 'date'
    		    @field = form.text_field rec.id, :class=> "input-block-level date_format", :value=> val
    		elsif rec.type_field == 'text_area'
    		    @field = form.text_area rec.id, :rows=>"6", :class=> "input-block-level", :value=> val
            elsif rec.type_field == 'select'
                if (rec.options =~ /url:([^\s]*)/)==0
                    @get_ajax_class = "ajax_customer"
                    #val = [] if val.class == String || val.nil?
                    #@field = form.text_field rec.id, :value=> val.join(','), :class=> "input-block-level #{rec.type_field} multiselect2 #{@get_ajax_class}"
                else
                    @get_ajax_class = "no_ajax_customer"
                    #@field = form.select rec.id, get_collection(rec.options, val), {}, :class=> "input-block-level multiselect2 #{@get_ajax_class}", :multiple=>"multiple"
                end
                get_collection(rec, val)
                @field = form.select rec.id, rec.select_opts, {}, { :class=> "input-block-level multiselect", :multiple=>"multiple" }.merge(rec.html_options)

            elsif rec.type_field == 'widget'
                if rec.options == 'component'
                    @component = eval(rec.widget).new()
                    params[:process_instance_id] = params[:id]
                    @component.widget_request = true
                    @component.step = rec.step
                    @component.process_instance = Guara::Jobs::ProcessInstance.find params[:process_instance_id]

                    @component.request = request
                    @component.response = response
                    @component.params = params

                    return @component.index
                else
                    return render :partial=> "guara/jobs/widgets/form_#{rec.widget}", :locals=> {:value=> val, :field_form_name=> process_instance_field_form_name(rec)}
                end
            else
                @field = form.text_field rec.id, :value=> val, :class=> "input-block-level #{rec.type_field}"
        	end

        	return "<div class=\"control-group\">
        			<label class=\"control-label strong\" for=\"#{rec.id}\">#{rec.title} #{'<span style="color:red">*</span>' if rec.required == true}</label>
    			        <div class=\"controls\">
    						#{@field}
    					</div>
    				</div>"
        end
        
        def process_instance_field_form_name(step_attr)
          "step_instance_attrs[#{step_attr.id}]"
        end

        def get_fields(form, steps, vals, column)
        	@steps_attrs_column = []
        	if steps[column] != nil
    	    	steps[column].each do |s|
    	    		@steps_attrs_column << get_field(form, s, vals)
    	    	end
        	end
        	return @steps_attrs_column.join("").html_safe
        end

        def get_attr_value(process_instance, step_attr)
            instance_attr = StepInstanceAttr.where(process_instance_id: process_instance.id, step_attr_id: step_attr.id).first
          
          if instance_attr.nil? || instance_attr.value.nil?
            value =  process_instance_field_multi_values(step_attr, instance_attr)
          else
            value = instance_attr.value
          end
          
          return value
        end
        
        def instance_process_field(form, process_instance, step_attr)
            attr_value = get_attr_value(process_instance, step_attr)
            response = get_field(form, step_attr, attr_value)

            if response.class == Array
                raw response.join("").html_safe
            else
                raw response
            end    
        end
        
        def process_instance_field_multi_values(step_attr, attr_instance)
         return nil if attr_instance.nil?
         
         ret = []
         
          attr_instance.values.each do |v|
            ret << { :value=> v.value, :step_attr_option=> step_attr.options }
          end
          
          return ret
        end

        def process_instance_js_required_fields(step)
            @required_fields = []
            step.attrs.each do |step_attr|
                if step_attr.type_field != 'widget' and step_attr.required == true
                    @required_fields << "if((jQuery('#step_instance_attrs_#{step_attr.id}')[0]) && jQuery.trim($('#step_instance_attrs_#{step_attr.id}').val())== '') {alert('Preencha o campo #{step_attr.title}');return false;};"
                end
            end

            return @required_fields.join("").html_safe
        end

        def show_attr_value(process_instance, step_attr)
            attr_value = get_attr_value(process_instance, step_attr)

            @label = []
            if attr_value.class == Array
                attr_value.each do |attr|
                    @label << content_tag(:span, get_value_model(attr[:step_attr_option], attr[:value]), :class => "strong")
                end
            elsif attr_value.class == String
                @label << attr_value
            end
            return @label.join(", ").html_safe
        end

      end
  end
end
