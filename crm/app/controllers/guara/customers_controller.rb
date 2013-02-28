

module Guara
  class CustomersController < BaseController
    load_and_authorize_resource :class => Guara::Customer, :except => [:create]
    before_filter :custom_load_creator, :only => :create
    before_filter :filter_before_changes, :only => [:create,:update]
  
    autocomplete :business_segment, :name, :full => true
    autocomplete :business_activity, :name, :full => true
    
    include BaseHelper
    include Select2Helper

    helper CrudHelper
  
    def index
      @sels = params["sels"] || []
      
      #@query = Customer.search(params[:search])
      #@search = @query.result
      
      param_search = params[:search]
      
      if !param_search.nil? && param_search.size>0 
        filter_multiselect param_search, :customer_guara_customer_pj_type_activities_business_segment_id_in
        filter_multiselect param_search, :customer_guara_customer_pj_type_activities_id_in
      end
      
      @search = Customer.search(param_search)
      
      #@customers = Customer.search_by_name(@customers, params[:name]).paginate(page: params[:page], :per_page => 5)
      if class_exists?("Ransack")
        @customers = @search.result().paginate(page: params[:page], :per_page => 10)
      else
        @customers = @search.paginate(page: params[:page], :per_page => 10)
      end
      params[:search] = {} if params[:search].nil?
    end
    
    
  
    def show
      @task = @customer.tasks.build
      @tasks = @customer.tasks.paginate(page:params[:task_page] || 1, per_page: 4)
    
      @selected_department = params[:department]
      @contacts = @customer.contacts
      @contacts = Contact.search_by_params @contacts, department_id: @selected_department if @selected_department
    
      render "show2."+@customer.customer.prefix
    end
  
    def disable
    
    end
  
    def new
      @person = CustomerPj.new
      @customer.customer = @person
      @segments = BusinessSegment.all
      render "new."+preferences_customer_type?.to_s
    end
  
    def update_advanced_fields
                    
      #@person.segments = params[:segments_select] ? params[:segments_select].collect { |bsid| BusinessSegment.find bsid }.uniq : []
      activities = params[:activities] ? params[:activities].collect { |baid| BusinessActivity.find_by_id baid }.uniq : []
      activities.delete nil
      @person.activities = activities
      
      @person.associateds = params[:associateds_select] ? params[:associateds_select].collect { |assoc| CustomerPj.find assoc }.uniq : []    
    end
    
    def create
      if (params[:customer]==nil)
        return
      end
      
      @customer = Guara::Customer.new(params[:customer])
      @customer.customer = Guara::CustomerPj.new(params[:customer_pj])
      @person = @customer.customer
      
      update_advanced_fields
    
      if save_customer
        flash[:success] = t("helpers.forms.new_sucess")
        redirect_to customer_path(@customer)
      else
        valid = @customer.valid? && @person.valid?
        Rails.logger.debug [@customer.errors.inspect, @person.errors.inspect].to_s
        authorize! :new, @customer, 'new.'+preferences_customer_type?.to_s
        render 'new.'+preferences_customer_type?.to_s
      end
    end
    
    def save_customer
      res = false
      Guara::Customer.transaction do
        debugger
        raise ActiveRecord::Rollback if !@person.save
        @customer.customer = @person
        raise ActiveRecord::Rollback if !@customer.save
        @customer.update_attribute :customer_id, @person.id        
        res = true
      end
      
      res
    end
  
    def update
    
      params_pj = params[:customer][:customer_pj]
      params[:customer].delete :customer_pj
    
      #@customer = Customer.find params[:id]
      @person = @customer.customer
    
      update_advanced_fields
      
      
      @customer.attributes = params[:customer]
      @person.attributes = params_pj
      
      if save_customer
        flash[:success] = t("helpers.forms.new_sucess")
        redirect_to customer_path(@customer)
      else
        render 'new.'+preferences_customer_type?.to_s
      end
    end
  
    def edit
      @customer = Customer.find params[:id]
      @person = @customer.customer 
    
      @customer.emails.build
    end
  
    def filter_before_changes
      authorize! params[:action].to_sym, @customer
    
      params[:customer][:doc].gsub! /[\.\/-]/, "" if params[:customer][:doc]
      params[:customer][:doc_rg].gsub! /[\.\/-]/, "" if params[:customer][:doc_rg] 
      params[:customer][:postal].gsub! /[\.\/-]/, "" if params[:customer][:postal]
    end
  
  
    def multiselect_business_segments
      render :json => BusinessSegment.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def multiselect_business_activities
      render :json => BusinessActivity.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def custom_load_creator
      params[:customer_pj] = params[:customer][:customer_pj]
      params[:customer].delete :customer_pj
    end
  
    def multiselect_customers_pj
      render :json => CustomerPj.includes(:customer).where(["(guara_people.name ilike ?  or guara_people.name_sec ilike ?)", params[:tag]+"%", params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.customer.name } }
    end
  end
end