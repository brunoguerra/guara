module Guara
	module Jobs
		class VacancyFinalResultController < Guara::BaseController
			load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
            load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
            load_and_authorize_resource :psychological, :class => "Guara::Jobs::VacancyProfessionalsPsychologicalEvaluation"
    		
            include ::Guara::Jobs::ActiveProcess::ProcessStepComponent

    		def load_selecteds_professionals()
    			@vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
    			@psychological = VacancyProfessionalsPsychologicalEvaluation.joins(:scheduling)
                .where(:guara_jobs_vacancy_scheduling_professionals=> {:vacancy_id=> @vacancy.id})
		    end

            def show
                load_selecteds_professionals()
                render :partial => "guara/jobs/vacancy_final_result/widget_show", :locals => { vacancy: @vacancy}
            end

    		def index
    			load_selecteds_professionals()   
                render :partial => "guara/jobs/vacancy_final_result/widget_index", :locals => { vacancy: @vacancy}
    		end

            def new
                @vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
                psychological = VacancyProfessionalsPsychologicalEvaluation.find(params[:psychological_id])
                @final_result = VacancyFinalResult.new(
                    :vacancy_professionals_psychological_evaluation_id=> psychological.id, 
                    :vacancy_scheduling_professional_id=> psychological.vacancy_scheduling_professional_id
                )

                render :partial => "guara/jobs/vacancy_final_result/widget_form", :locals => { vacancy: @vacancy_id}
            end

            def edit
                @final_result = VacancyFinalResult.find_by_vacancy_professionals_psychological_evaluation_id(params[:psychological_id])
                render :partial => "guara/jobs/vacancy_final_result/widget_form", :locals => { vacancy: @vacancy_id}
            end

            def create
                @final_result = VacancyFinalResult.create(params[:jobs_vacancy_final_result])
                redirect_to edit_process_instance_path(params[:process_instance_id], :edit_step=> params[:edit_step])
            end

            def update
                @final_result = VacancyFinalResult.find(params[:id]).update_attributes(params[:jobs_vacancy_final_result])
                redirect_to edit_process_instance_path(params[:process_instance_id], :edit_step=> params[:edit_step])
            end

		end
	end
end