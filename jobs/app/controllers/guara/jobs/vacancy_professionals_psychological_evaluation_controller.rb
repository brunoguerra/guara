module Guara
	module Jobs
		class VacancyProfessionalsPsychologicalEvaluationController < Guara::BaseController
			load_and_authorize_resource :vacancy, :class => "Guara::Jobs::Vacancy"
            load_and_authorize_resource :scheduling, through: :vacancy, :class => "Guara::Jobs::VacancySchedulingProfessional"
            load_and_authorize_resource :customer_interview, :class => "Guara::Jobs::VacancyCustomerInterview"
    		
            include ::Guara::Jobs::ActiveProcess::ProcessStepComponent

    		def load_selecteds_professionals()
    			@vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
    			@customer_interviews = VacancyCustomerInterview.joins(:scheduling)
                .where(:guara_jobs_vacancy_scheduling_professionals=> {:vacancy_id=> @vacancy.id}, :return_interview=> 0)
		    end

            def show
                load_selecteds_professionals()
                render :partial => "guara/jobs/vacancy_psychological_evalution/widget_show", :locals => { vacancy: @vacancy}
            end

    		def index
    			load_selecteds_professionals()   
                render :partial => "guara/jobs/vacancy_psychological_evalution/widget_index", :locals => { vacancy: @vacancy}
    		end

            def new
                @vacancy = @vacancy || Vacancy.find_by_process_instance_id(params[:process_instance_id])
                customer_interview = VacancyCustomerInterview.find(params[:customer_interview_id])
                @psychological = VacancyProfessionalsPsychologicalEvaluation.new(
                    :vacancy_customer_interview_id=> customer_interview.id, 
                    :vacancy_scheduling_professional_id=> customer_interview.vacancy_scheduling_professional_id
                )

                render :partial => "guara/jobs/vacancy_psychological_evalution/widget_form", :locals => { vacancy: @vacancy_id}
            end

            def edit
                @psychological = VacancyProfessionalsPsychologicalEvaluation.find_by_vacancy_customer_interview_id(params[:customer_interview_id])
                render :partial => "guara/jobs/vacancy_psychological_evalution/widget_form", :locals => { vacancy: @vacancy_id}
            end

            def create
                @data = params[:jobs_vacancy_professionals_psychological_evaluation]
                process_params_files()

                @psychological = VacancyProfessionalsPsychologicalEvaluation.create(@data)
                redirect_to edit_process_instance_path(params[:process_instance_id], :edit_step=> params[:edit_step])
            end

            def update
                @data = params[:jobs_vacancy_professionals_psychological_evaluation]
                process_params_files()
                @psychological = VacancyProfessionalsPsychologicalEvaluation.find(params[:id]).update_attributes(@data)

                redirect_to edit_process_instance_path(params[:process_instance_id], :edit_step=> params[:edit_step])
            end

            def process_params_files
                @data[:file1] = save_report_file(@data[:vacancy_scheduling_professional_id], @data[:file1]) if @data[:file1]
                @data[:file2] = save_report_file(@data[:vacancy_scheduling_professional_id], @data[:file2]) if @data[:file2]
                @data[:file3] = save_report_file(@data[:vacancy_scheduling_professional_id], @data[:file3]) if @data[:file3]
            end

            def save_report_file(scheduling_id, file)
                if !file.nil?
                    name = file.original_filename
                    directory = Rails.root.join("../guara/jobs/lib/guara/jobs/vacancy_professionals_psychological_evaluation/#{scheduling_id}")
                    if !File.exist?(directory)
                        Dir.mkdir directory
                    end
                    path = File.join(directory, name)
                    File.open(path, "wb") { |f| f.write(file.read) }
                else
                    name = nil
                end

                return name
            end

		end
	end
end