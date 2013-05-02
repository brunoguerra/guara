module Guara
	module Jobs
	  class ProfessionalsController < BaseController
	  	before_filter :find_customers_by_jobs_customer_id_and_professional, :except => [:search, :search_select]
	  	load_and_authorize_resource :customer, :except => [:search, :search_select]
    	load_and_authorize_resource :class => Guara::Jobs::Professional, :singleton => true, :except => [:search, :search_select]

    	include CustomersHelper
    	include Select2Helper
    	include CrudHelper

    	helper CustomersHelper
    	helper CrudHelper


    	def index
    		 redirect_to :show
    	end

	    def search
        
        peform_search
        
		    params[:search] = {} if params[:search].nil?
		    respond_to do |format|
	            format.json { render "guara/jobs/professionals/_list_professionals.html.erb" }
	            format.html { render "search" }
            end

            authorize! :read, Guara::Jobs::Professional
	    end
	    
	    def search_select
	      term = params[:search]
	      params[:search] = { :person_name_contains => term }
	      
	      peform_search
	      
	      respond_to do |format|
	        format.json { render :json => { results: @professionals.map { |p| { :value => p.id, :description => p.name } } } }
        end
        
        authorize! :read, Guara::Jobs::Professional
      end

	    def searched_professionals
	    	@professionals || Professional.paginate(page: 1, per_page: 10)
	    end

	    def searched_search
	    	@search || {:none => true}
	    end
	    
	    def peform_search
	      param_search = params[:search]

		    if !param_search.nil? && param_search.size>0 
      		filter_multiselect param_search, :vacancy_specification_roles_business_action_id_in
      		filter_multiselect param_search, :formations_level_education_id_in
    		end
	    	
	    	@search = Professional.search(param_search)


	    	if class_exists?("Ransack")
		        @professionals = @search.result().paginate(page: params[:page], :per_page => 10)
		    else
		        @professionals = @search.paginate(page: params[:page], :per_page => 10)
		    end
	    end
	  	
	  	def new
	  		build_professional()
	  	end

	  	def build_professional()
	  		build_empty_many_relation(@professional.formations)
	  		build_empty_many_relation(@professional.professional_languages)
	  		build_empty_many_relation(@professional.professional_experiences)
	  		@professional.professional_experiences.each {|e| build_empty_many_relation(e.careers) }
	  		build_empty_one_relation(@professional, :attachment)
	  		build_empty_one_relation(@professional, :vacancy_specification)
	  	end

	    def show
	    	@professional = Professional.find(params[:id])
	    end # SHOW

	    def manage_advanced_fields()
	    	@professional.vacancy_specification = VacancySpecification.new(params[:jobs_professional][:vacancy_specification_attributes]) if @professional.vacancy_specification.nil?

	    	roles_id = params[:roles] || []
	    	@professional.vacancy_specification.roles = roles_id.map { |r_id| Role.find r_id }.uniq

	    end # MÉTODO PARA SELEÇÃO DE VÁRIOS CHECKBOX


	    def create
	    	@professional = Professional.new(params[:jobs_professional])
	    	@professional.person = @customer
	    	manage_advanced_fields()

	    	respond_to do |format|
	            if @professional.save
	              format.html { redirect_to(jobs_customer_professional_path(@customer, @professional), :notice => 'Contact was successfully created.') }
	              format.json { render :json => @professional, :status => :created, :location => @professional}
	            else
	            	build_professional()
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
		          format.html { redirect_to(jobs_customer_professional_path(@customer, @professional), :notice => t('forms.update.sucess')) }
		          format.json { head :ok }
		        else
		          format.html { render :action => "edit" }
		          format.json { render :json => @professional.errors, :status => :unprocessable_entity }
		        end
		      end
	    end# UPDATE

 		
	    def find_customers_by_jobs_customer_id_and_professional
	    	@customer = Guara::Customer.find params[:jobs_customer_id]
	    	if [:new, :create].include? params[:action]
	    		@professional = Professional.new(params[:professional])
	    	else  
	    		@professional = Professional.where(person_id: @customer.id, id: params[:id]).first
	    	end
	    end
	    
	  end
	end
end
