module Guara
	module Jobs
		class VacancyReportsController < Guara::Jobs::ProcessInstanceController
			
			def index
				super
				@process_instances = reject_roles_not_in(params[:role_equals]) if !params[:role_equals].empty?
			end

			def reject_roles_not_in(role_id)
				process_instance = @process_instance.reject do |p|
					role_id = p.custom_process.step.attrs.where(:options=> '$Guara::Jobs::Role').first()
					role_id.step_instance_attrs.where("process_instance_id = #{p.id} AND value = #{role_id}")
							.count() == 0
				end
			end

		end
	end
end