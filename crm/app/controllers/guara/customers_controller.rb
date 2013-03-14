

module Guara
  class CustomersController < BaseController
    load_and_authorize_resource :class => Guara::Customer, :except => [:create]
    before_filter :custom_load_creator, :only => [:create,:update]
    before_filter :filter_before_changes, :only => [:create,:update]
  
    autocomplete :business_segment, :name, :full => true
    autocomplete :business_activity, :name, :full => true
    
    include BaseHelper
    include Select2Helper

    helper CrudHelper
    helper CustomersHelper
  
    def index
      @sels = params["sels"] || []
      
      peform_search
      
      if class_exists?("Ransack")
        @customers = @search.result().paginate(page: params[:page], :per_page => 10)
      else
        @customers = @search.paginate(page: params[:page], :per_page => 50)
      end
    end
    
    def peform_search
      
      if !params[:search].nil? && params[:search].include?(:none) 
        params[:search] = {:mode_advanced => true}
      end
      
      param_search = params[:search] || session[:customers_search]
      session[:customers_search] = param_search
      params[:search] = param_search
      
      if !param_search.nil? && param_search.size>0 
        filter_multiselect param_search, :customer_guara_customer_pj_type_activities_business_segment_id_in
        filter_multiselect param_search, :customer_guara_customer_pj_type_activities_id_in
      end
      
      unless param_search.nil?
        param_search = param_search.dup
        mode = param_search.delete :mode_advanced
      end
      
      @search = Customer.search(param_search)
      #@search = Customer.search(param_search)
      
      params[:search] = {} if params[:search].nil?
    end

    def customer_association
      @sels = params["sels"] || []
      @customer = Guara::Customer.find params[:id]
    end
  
    def show
      @task = @customer.tasks.build
      @tasks = @customer.tasks.paginate(page:params[:task_page] || 1, per_page: 4)
    
      @selected_department = params[:department]
      @contacts = @customer.contacts
      @contacts = Contact.search_by_params @contacts, department_id: @selected_department if @selected_department
    
      render "show2"#+@customer.customer.prefix
    end
  
    def disable
    
    end
  
    def new
      @customer_type = get_customer_type()
      if @customer_type == "pj"
        @person = CustomerPj.new
      else
        @person = CustomerPf.new
      end
      
      @customer.customer = @person
      @segments = BusinessSegment.all
      
      render "new"
    end
    
    def get_customer_type()
      unless params[:type].nil?
        if (params[:type]=="com")
          "pj"
        else
          "pf"
        end
      else
        preferences_customer_type?.to_s
      end
    end
  
    def update_advanced_fields
      if @person.is_a?(CustomerPj)
        activities = params[:activities] ? params[:activities].collect { |baid| BusinessActivity.find_by_id baid }.uniq : []
        activities.delete nil
        @person.activities = activities
      
        @person.associateds = params[:associateds_select] ? params[:associateds_select].collect { |assoc| CustomerPj.find assoc }.uniq : []    
      end
    end
    
    def create
      if (params[:customer]==nil)
        return
      end
      
      @customer_type = get_customer_type()
      custom_load_creator() unless params[:customer][:customer_pj].nil? && params[:customer][:customer_pf].nil?
      
      @customer = Guara::Customer.new(params[:customer])
      if @customer_type == "pf"
        @customer.customer = Guara::CustomerPj.new(params[:customer_pj])
      else
        @customer.customer = Guara::CustomerPf.new(params[:customer_pf])
      end
      @person = @customer.customer
      
      update_advanced_fields
    
      if save_customer
        flash[:success] = t("helpers.forms.new_sucess")
        redirect_to customer_path(@customer)
      else
        valid = @customer.valid? && @person.valid?
        params_restore
        Rails.logger.debug [@customer.errors.inspect, @person.errors.inspect].to_s
        authorize! :new, @customer, 'new.'+preferences_customer_type?.to_s
        render 'new'
      end
    end
    
    def save_customer
      res = false
      Guara::Customer.transaction do
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
  
    def multiselect_business_activities
      render :json => BusinessActivity.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def multiselect_customers
      render :json => BusinessActivity.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def custom_load_creator
      customer_type = params[:customer][:customer_pj].nil? ?  :customer_pf : :customer_pj
      params[customer_type] = params[:customer][customer_type]
      params[:customer].delete customer_type
    end
    
    def params_restore
      @person.is_a?(CustomerPf) ? customer_type = :customer_pf : :customer_pj
      @customer_type = customer_type = :customer_pf ? "pf" : "pj"
      params[:customer][customer_type] = params[customer_type]
    end
  
    def multiselect_customers_pj
      render :json => CustomerPj.includes(:person).where(["(guara_people.name ilike ?  or guara_people.name_sec ilike ?)", params[:tag]+"%", params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.person.name } }
    end
  end
end