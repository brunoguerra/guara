module Guara
  class CustomersController < BaseController
    load_and_authorize_resource :class => Guara::Customer, :except => [:create, :multiselect_business_segments, :multiselect_business_activities, :multiselect_customers, :multiselect_customers_pj, :multiselect_customers_pj_customer_id]
    before_filter :custom_load_creator, :only => [:create,:update]
    before_filter :filter_before_changes, :only => [:create,:update]
  
    autocomplete :business_segment, :name, :full => true
    autocomplete :business_activity, :name, :full => true
    
    include BaseHelper
    include Select2Helper

    helper CrudHelper
    helper CustomersHelper
    helper TasksHelper
  
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
        params[:search] = { :mode_advanced => true }
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
      @person = @customer.customer
      load_customer_type
      @task = @customer.tasks.build
      @tasks = @customer.tasks.paginate(page:params[:task_page] || 1, per_page: 4)
    
      @selected_department = params[:department]
      @contacts = @customer.contacts
      @contacts = Contact.search_by_params @contacts, department_id: @selected_department if @selected_department
        
      if params[:format] == 'json'
        render "show_detailed", layout: false, :formats => [:html]
      else
        render "show_detailed"
      end
    end
  
    def disable
    
    end
  
    def new
      load_customer_type()
      if @customer_type == "pj"
        @person = CustomerPj.new
      else
        @person = CustomerPf.new
      end
     
      @customer.customer = @person
      @segments = BusinessSegment.all
      
      render "new"
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
      
      load_customer_type()
      custom_load_creator() unless params[:customer][:customer_pj].nil? && params[:customer][:customer_pf].nil?
      
      @customer = Guara::Customer.new(params[:customer])
      if @customer_type == "pf"
        @customer.customer = Guara::CustomerPf.new(params[:customer_pf])
      else
        @customer.customer = Guara::CustomerPj.new(params[:customer_pj])
      end
      @person = @customer.customer
      
      update_advanced_fields
    
      if save_customer
        flash[:success] = t("helpers.forms.new_sucess")
        redirect_to customer_path(@customer)
        render :formats => [:js] if params[:remote] == "true"
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
      @person = @customer.customer
      
      load_customer_type()
      
      @customer.attributes = params[:customer]
      
      if @person.is_a? Guara::CustomerPf
        @person.attributes = params[:customer_pf]
      else
        @person.attributes = params[:customer_pj]
      end
      
      update_advanced_fields
      
      if save_customer && @person.save
        flash[:success] = t("helpers.forms.new_sucess")
        if params[:remote] == "true"
          render :formats => [:js]
        else
          redirect_to customer_path(@customer)
        end
      else
        if params[:remote] == "true"
          render :json => { error: true, errors: @customer.errors }
        else
          render 'edit'
        end
      end
    end
  
    def edit
      @customer = Customer.find params[:id]
      @person = @customer.customer 
      load_customer_type()
      @customer.emails.build

      render layout: false if params[:remote] == "true"
    end
    
    def filter_before_changes
      authorize! params[:action].to_sym, @customer
      
      params[:customer][:doc].gsub! /[\.\/-]/, "" if params[:customer][:doc]
      params[:customer][:doc_rg].gsub! /[\.\/-]/, "" if params[:customer][:doc_rg] 
      params[:customer][:postal].gsub! /[\.\/-]/, "" if params[:customer][:postal]
      
      #@customer.phones.each { |p| params[:customer][:phones_attributes].merge({ :id => p.id, :_destroy => 1}) }
    end
    
    def multiselect_business_segments
      authorize! :read, Guara::BusinessSegment
      render :json => BusinessSegment.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def multiselect_business_activities
      authorize! :read, Guara::BusinessActivity
      render :json => BusinessActivity.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
  
    def multiselect_customers
      authorize! :read, Guara::Customer
      render :json => Customer.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
    end
    
    def load_customer_type()

      if !@person.nil?
        @customer_type = @person.prefix
      elsif !params[:type].nil?
        @customer_type = {
                            "com" => "pj",
                            "per" => "pf"
                        }[params[:type]]
      else
        @customer_type = preferences_customer_type?.to_s
      end
      
      if !@customer.nil? 
        2.times { @customer.phones.build if @customer.phones.size < 2 }
      end
    end
  
    def custom_load_creator
      customer_param = params[:customer][:customer_pj].nil? ?  :customer_pf : :customer_pj
      params[customer_param] = params[:customer][customer_param]
      params[:customer].delete customer_param
    end
    
    def params_restore
      customer_type = @person.is_a?(CustomerPf) ? :customer_pf : :customer_pj
      @customer_type = customer_type == :customer_pf ? "pf" : "pj"
      params[:customer][customer_type] = params[customer_type]
    end
  
    def multiselect_customers_pj
      authorize! :read, Guara::CustomerPj
      render :json => CustomerPj.includes(:person).where(["(guara_people.name ilike ?  or guara_people.name_sec ilike ?)", params[:search]+"%", params[:search]+"%"] ).collect { |c| { :id => c.id.to_s, :name => c.person.name } }
    end

    def multiselect_customers_pj_customer_id
      authorize! :read, Guara::CustomerPj
      render :json => CustomerPj.includes(:person).where(["(guara_people.name ilike ?  or guara_people.name_sec ilike ?)", params[:search]+"%", params[:search]+"%"] ).collect { |c| { :id => c.person.id, :name => c.person.name } }
    end

    def load_cities
      authorize! :read, Guara::City
      render :json => Guara::City.where(:state_id=> params[:state_id]).collect { |c| { :id => c.id.to_s, :value => c.name } }
    end

    def load_districts
      authorize! :read, Guara::District
      render :json => Guara::District.where(:city_id=> params[:city_id]).collect { |c| { :id => c.id.to_s, :value => c.name } }
    end
  end
end
