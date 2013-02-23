module Guara
	module Jobs
	  class ProfessionalsController < BaseController
	    load_and_authorize_resource :customer, :class => ::Guara::Customer
    	load_and_authorize_resource :through => :customer, :class => Guara::Jobs::Professional, :singleton => true, :except => :search

    	include CustomersHelper
    	include Select2Helper


    	def index
    		 redirect_to :show
    	end

	    def search
	    	param_search = params[:search]

		    if !param_search.nil? && param_search.size>0 
        		filter_multiselect param_search, :vacancy_specification_roles_business_action_id_in
        		filter_multiselect param_search, :formations_level_education_id_in
      		end
	    	
	    	@search = Professional.search(param_search)


	    	if class_exists?("Ransack")
		        @professional = @search.result().paginate(page: params[:page], :per_page => 10)
		    else
		        @professional = @search.paginate(page: params[:page], :per_page => 10)
		    end

		    params[:search] = {} if params[:search].nil?

	    	

	    end
	  	
	  	def new
	  		@professional.formations.build
	  		@professional.professional_experiences.build
	  		@professional.vacancy_specification = VacancySpecification.new
	  	end

	    def show
	    	@professional = Professional.find(params[:id])
	    end # SHOW

	    def manage_advanced_fields()
	    	@professional.vacancy_specification = VacancySpecification.new(params[:jobs_professional][:vacancy_specification_attributes]) if @professional.vacancy_specification.nil?

	    	roles_id = params[:roles] || []
	    	@professional.vacancy_specification.roles = roles_id.map { |r_id| Role.find r_id }.uniq
	    end # MÉTODO PARA SELEÇÃO DE VÁRIOS CARGOS


	    def create
	    	@professional = Professional.new(params[:jobs_professional])
	    	@professional.person = @customer
	    	#@professional.vacancy_specification = VacancySpecification.new(params[:professional][:vacancy_specification]) 
	    	manage_advanced_fields()

	    	respond_to do |format|
	            if @professional.save
	              format.html { redirect_to(customer_professional_path(@customer, @professional), :notice => 'Contact was successfully created.') }
	              format.json { render :json => @professional, :status => :created, :location => @professional}
	            else
	              format.html { render :action => "new" }
	              format.json { render :json => @professional.errors, :status => :unprocessable_entity }
	            end
            end
	    end # CREATE

	    def edit
	    	 @professional = Professional.find(params[:id])
	    end # EDIT

	    def update
	    	 @professional = Professional.find(params[:id])

	    	 manage_advanced_fields()

		     respond_to do |format|
		        if @professional.update_attributes(params[:jobs_professional])
		          format.html { redirect_to(customer_professional_path(@customer, @professional), :notice => t('forms.update.sucess')) }
		          format.json { head :ok }
		        else
		          format.html { render :action => "edit" }
		          format.json { render :json => @professional.errors, :status => :unprocessable_entity }
		        end
		      end
	    end# UPDATE

 
	  end
	end
end
