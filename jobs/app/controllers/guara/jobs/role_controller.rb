module Guara
	module Jobs
	  class VacancySpecificationController < BaseController
	    skip_authorization_check

	    def index
	    	@search = VacancySpecification.search(params[:search])

	    	if class_exists?("Ransack")
		        @vacancy_specification = @search.result().paginate(page: params[:page], :per_page => 10)
		    else
		        @vacancy_specification = @search.paginate(page: params[:page], :per_page => 10)
		    end
		    params[:search] = {} if params[:search].nil?
	    end
	  
	    def show
	    	@vacancy_specification = VacancySpecification.find(params[:id])
	    end

	    def new
	    	@vacancy_specification = VacancySpecification.new
	    	@role = Role.new
	    end

	    def create
	    	@vacancy_specification = VacancySpecification.new(params[:jobs_professional])

	    	respond_to do |format|
            if @vacancy_specification.save
              format.html { redirect_to(vacancy_specification_index_path(@order), :notice => 'Contact was successfully created.') }
              format.json { render :json => @vacancy_specification, :status => :created, :location => @vacancy_specification}
            else
              format.html { render :action => "new" }
              format.json { render :json => @vacancy_specification.errors, :status => :unprocessable_entity }
            end
            end
	    end

	    def edit
	    	 @vacancy_specification = VacancySpecification.find(params[:id])
	    end



	 
	  end
	end
end
