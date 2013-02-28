module Guara
    module Jobs
      module ProcessInstanceHelper

      	def get_collection(alias_model, vals)
            vals = [] if vals.class == String
   		    if alias_model == 'role'
                options_for_select(Guara::Jobs::Role.all.collect { |ff| [ff.name, ff.id] }, vals.collect { |fs| fs[:value] })
            elsif alias_model == 'consultant'
                options_for_select(Guara::Jobs::Consultant.all.collect { |ff| [ff.name, ff.id] }, vals.collect { |fs| fs[:value] })
            else
                options_for_select(Guara::Jobs::Professional.all.collect { |ff| [ff.person.name, ff.id] }, vals.collect { |fs| fs[:value] })
    		end
    	end

        def get_value_model(alias_model, id)
           if alias_model == 'role'
                @model = Guara::Jobs::Role.find id
                return @model.name
            elsif alias_model == 'consultant'
                @model = Guara::Jobs::Consultant.find id
                return @model.name
            else
                @model = Guara::Jobs::Professional.find id
                return @model.person.name
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
                return render :partial=> "guara/jobs/widgets/form_#{rec.widget}", :locals=> {:value=> val[rec.id], :field_form_name=> process_instance_field_form_name(rec)}
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
