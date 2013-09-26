module Guara
  class ContactsController < BaseController
    load_and_authorize_resource :customer, :class => Guara::Customer, :except => [:multi, :exporter]
    load_and_authorize_resource :through => :customer, :class => Guara::Contact, :except => [:multi, :exporter]
  
    helper CustomersHelper
    helper CrudHelper

    include Select2Helper

    # GET customers/1/contacts
    # GET customers/1/contacts.json
    def index  
      @sels = params["sels"] || []
      @search = @customer.contacts.search(params[:search])
      @contacts = @search.paginate(page: params[:page], :per_page => 20)

      respond_to do |format|
        format.html # index.html.erb
        format.json do
          #@content = render_to_string( :template => "contacts/_list", :locals => { items: @customer.contacts }, :formats => :html, :layout => false)
          #render :json => @content, :content_type => "application/json"
          render :partial => "list", :locals => { items: @contacts, :layout => false }, :formats => :html, :layout => false
          end
      end
    end
    
    def multi
      authorize! :edit, Guara::Contact
      @customer = Customer.find params[:customer_id]

      respond_to do |format|
        if @customer.update_attributes params[:customer]
          format.html { redirect_to :controller => :contacts, :action => :index }
          format.json do 
            contacts_json = []
            @customer.contacts.each do |contact|
              contacts_json << contact.attributes
            end
            render :json => { success: true, data: contacts_json }
          end 
          format.js do 
            @contacts = @customer.contacts
            render :partial => "guara/contacts/list_contacts.js" 
          end
        else
          format.html { render "_list_editable" }
          format.json { render :json => { success: false } }
          format.js
        end
      end
    end
  
    def self.select_departments
      BusinessDepartment.all
    end

    # GET customers/1/contacts/1
    # GET customers/1/contacts/1.json
    def show
      @customer = Customer.find(params[:customer_id])
      @contact = @customer.contacts.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render "show", :layout => false, :formats => [:html] }
      end
    end

    # POST customers/1/contacts
    # POST customers/1/contacts.json
    def create
      @customer = Customer.find(params[:customer_id])
      @contact = @customer.contacts.build(params[:contact])

      respond_to do |format|
        if @contact.save
          format.html { redirect_to([@contact.customer, @contact], :notice => 'Contact was successfully created.') }
          format.json { render :json => @contact, :status => :created, :location => [@contact.customer, @contact] }
        else
          format.html { render :action => "new" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT customers/1/contacts/1
    # PUT customers/1/contacts/1.json
    def update
      @customer = Customer.find(params[:customer_id])
      @contact = @customer.contacts.find(params[:id])

      respond_to do |format|
        if @contact.update_attributes(params[:contact])
          format.html { redirect_to([@contact.customer, @contact], :notice => t('forms.update.sucess')) }
          format.json { head :ok }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE customers/1/contacts/1
    # DELETE customers/1/contacts/1.json
    def destroy
      @customer = Customer.find(params[:customer_id])
      @contact = @customer.contacts.find(params[:id])
      @contact.destroy

      respond_to do |format|
        format.html { redirect_to customer_contacts_url(customer) }
        format.json { head :ok }
      end
    end

    def exporter

      if !params[:search].nil? && params[:search].size>0 
        filter_multiselect params[:search], :customer_customer_guara_customer_pj_type_activities_business_segment_id_in
        filter_multiselect params[:search], :customer_customer_guara_customer_pj_type_activities_id_in
      end

      @search = Guara::Contact.search(params[:search])
      if can? :manage, @contacts
        @contacts = @search.paginate(:page => params[:page], :per_page => 50)
      else
        @contacts = @search.paginate(:page => 1, :per_page => 5)
      end
      authorize! :read, @contacts
      params[:search] = {} if params[:search].nil?
    end

  end
end