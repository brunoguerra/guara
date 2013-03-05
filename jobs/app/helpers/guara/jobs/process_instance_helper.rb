module Guara
    module Jobs
      module ProcessInstanceHelper
        #include Guara::Jobs::ActiveProcess::ProcessStepComponent
      	def get_collection(vals, sels)
            sels = [] if vals.class == String
            vals.strip!
            if !(vals.nil? && vals.empty?) && vals[0]=='$'
                model = vals[1..1000]
                model = eval model
                if (model.respond_to?(:select_options))
                    options = model.select_options
                else
                    options = model.all
                end
       		    
                options_for_select(options.map { |ff| [ff.name, ff.id] }, sels.collect { |fs| fs[:value] })
            else
                index = -1
                options_for_select(vals.split(',').each { |ff| index+=1; [index, ff] }, sels.collect { |fs| fs[:value] })
            end
    	end

        def get_value_model(vals, id)
            vals = [] if vals.class == String
            vals.strip!

            if !(vals.nil? && vals.empty?) && vals[0]=='$'
                model = vals[1..1000]
                model = eval model
              
                record = model.find id
                
                
                return name_or_nothing record.name
            else
                vals.split(',')[id]
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
    		    @field = form.text_field rec.id, :class=> "input-block-level date_format", :value=> val[rec.id]
    		elsif rec.type_field == 'textarea'
    		    @field = form.text_area rec.id, :rows=>"6", :class=> "input-block-level", :value=> val[rec.id]
            elsif rec.type_field == 'select'
                @field = form.select rec.id, get_collection(rec.options, val[rec.id]), {}, :class=> "input-block-level multiselect", :multiple=>"multiple"
            elsif rec.type_field == 'section' || rec.type_field == 'widget'
                if rec.options == 'component'
                    @component = eval(rec.widget).new()
                    params[:process_instance_id] = params[:id]
                    @component.request = request
                    @component.response = response
                    @component.params = params

                    return @component.index
                else
                    return render :partial=> "guara/jobs/widgets/form_#{rec.widget}", :locals=> {:value=> val[rec.id], :field_form_name=> process_instance_field_form_name(rec)}
                end
            else
                @field = form.text_field rec.id, :value=> val[rec.id], :class=> "input-block-level"
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

        def get_required_fields(step_attrs)
            @required_fields = []
            step_attrs.each do |a,b|
                b.each do |c|
                    @required_fields << "if(jQuery.trim($('#step_instance_attrs_#{c.id}').val())== '') {alert('Preencha o campo #{c.title}');return false;};" if c.type_field != 'widget' and c.required == true
                end
            end

            return @required_fields.join("").html_safe
        end

        def show_values_select(val)
            @label = []
            if val.class == Array
                val.each do |k|
                    @label << content_tag(:span, get_value_model(k[:step_attr_option], k[:value]), :class => "strong")
                end
            elsif val.class == String
                @label << val
            end

            return @label.join(", ").html_safe
        end

        def get_value_select(val)
            return get_value_model(val[:step_attr_option], val[:value])
        end

      end
  end
end
