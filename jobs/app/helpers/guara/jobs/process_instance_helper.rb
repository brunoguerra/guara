module Guara
    module Jobs
      module ProcessInstanceHelper

      	def get_collection(alias_model, vals)
    		#Retornar Model de Clientes ou Empresas
    		if alias_model == 'role'
                Guara::Jobs::Role.all.map{ |c| [c.name, c.id] }
                options_for_select(Guara::Jobs::Role.all.collect { |ff| [ff.name, ff.id] }, vals.collect { |fs| fs.value })
            elsif alias_model == '*****'
                options_for_select(Guara::Jobs::Professional.all.collect { |ff| [ff.name, ff.id] }, vals.collect { |fs| fs.value })
            elsif alias_model == 'consultant'
                options_for_select(Guara::Jobs::Consultant.all.collect { |ff| [ff.name, ff.id] }, vals.collect { |fs| fs.value })
            else
                options_for_select(Guara::Jobs::Professional.all.collect { |ff| [ff.person.name, ff.id] }, vals.collect { |fs| fs.value })
    		end
    	end

    	def show_label_tag(label)
          label_tag label, label+":", :class => "strong"
        end

        def show_span_tag(text)
        	content_tag(:span, text+":", :class => "strong")
        end

        def get_field(form, rec, val)
        	@field = ""
        	if rec.type_field == 'date'
    		    @field = form.text_field rec.id, :class=> "input-block-level date_format", :value=> val[rec.id]
    		elsif rec.type_field == 'textarea'
    		    @field = form.text_area rec.id, :rows=>"6", :class=> "input-block-level", :value=> val[rec.id]
            elsif rec.type_field == 'select'
                @field = form.select rec.id, get_collection(rec.options, val[rec.id]), {}, :class=> "input-block-level multiselect", :multiple=>"multiple"
            else
                @field = form.text_field rec.id, :value=> val[rec.id], :class=> "input-block-level"
        	end

        	return "<div class=\"control-group\">
        			<label class=\"control-label strong\" for=\"#{rec.id}\">#{rec.label} #{'<span style="color:red">*</span>' if rec.required == true}</label>
    			        <div class=\"controls\">
    						#{@field}
    					</div>
    				</div>"
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
                    @required_fields << "if(jQuery.trim($('#step_instance_attrs_#{c.id}').val())== '') {alert('Preencha o campo #{c.label}');return false;};"
                end
            end

            return @required_fields.join("").html_safe
        end

        def show_value_field(rec, vals)
            if rec.type_field == 'select'
                #vals[rec.id] = getCollection
            end
        end

      end
  end
end
