#encoding: utf-8

module Guara
  class Person < ActiveRecord::Base
    attr_accessible :doc, :doc_rg, :name, :birthday, :name_sec, :address, :state_id, :city_id, :district_id,
                    :is_customer, :person, :customer, :customer_type, :customer_id, :postal, :emails, :complete, :state, :city, :district, :phone, 
                    :fax, :social_link, :site, :enabled, :other_contacts, :notes, :emails_attributes, :contacts_attributes,
                    :external_key

    cattr_writer :modules

    #attr_protected
  
    before_validation :before_validation_completed
  
    include ActiveExtend::ActiveDisablable
    include StringHelper
  
    default_scope order: "name"
  
    #=========================== associations <--------------------------------------------
  
    belongs_to :customer, :polymorphic => true, dependent: :destroy
    alias_method :person, :customer
    alias_method :person=, :customer=
    
    has_many :tasks, dependent: :destroy, :as => :interested
    has_many :emails, :as => :emailable, dependent: :destroy
    has_many :contacts, dependent: :destroy
    has_many :order
  
    belongs_to :state
    belongs_to :city
    belongs_to :district
    
  
    #============================ 
  
    accepts_nested_attributes_for :emails, :reject_if => lambda { |a| a[:email].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :contacts, :reject_if => lambda { |a| a[:name].blank? && a[:phone].blank? }, :allow_destroy => true
  
    #=========================== VALIDATE <------------------------------------------------
  
  
    VALID_NAME_REGEX = /\A([[[:alpha:]]0-9.,;\s\'\"\-–\/&\*\(\)`´%!\+])+\z/i
  
    validates :doc, :customer_cnpj => true
    validates :doc, :presence => true, :uniqueness => true, :if => :doc_needs?
    validates :name, :presence => true, length: { maximum: 120 }, format: { with: VALID_NAME_REGEX }, uniqueness: true
    validates :address, :presence => true, length: { maximum: 150 }, :if => :complete?
    validates :state_id, :presence => true, :if => :complete?
    validates :city_id, :presence => true, :if => :complete?
    validates :district_id, :presence => true, :if => :complete?
    validates :phone, :presence => true, :if => :complete?


    # ---> public ----------------------------------------------------------------------
    public
      ##
      # The bussinesses done at the time
      #
      # @return [OpenStruct]    The struct containing CompanyBusiness as :business and Last Time of Business Deal as business_at
      def businesses
        resolution = SystemTaskResolution.RESOLVED_WITH_BUSINESS
        businesses = self.tasks.unscoped.joins(:type).select("company_business_id, max(finish_time) AS business_at").where({resolution_id: 4, interested_id: self}).group(:company_business_id)
        #puts businesses.inspect
        businesses.collect { |b| OpenStruct.new(business: CompanyBusiness.find_by_id(b.company_business_id), business_at: b.business_at) }
      end
  
    # -------------------------------------------------------------------------> validates
      def self.search_by_name(customers, name)
        conditions = []
        conditions_and = []
        conditions_params = []
        if name
          name = name.upcase
          conditions_and << 'upper(name) LIKE ?'
          conditions_params << "%#{name}%"
        end
    
        conditions << conditions_and.join(" and ")
        conditions_params.each { |p| conditions << p  }
    
        if conditions.count>0
          logger.debug customers
          ret = customers.where(conditions)
        else
          []
        end
    
      end
  
      def format_address
        (self.address ? self.address : "") + ", " + name_or_empty(self.district) + ", " + name_or_empty(self.city) + ", " + name_or_empty(self.state)
      end
  
      def doc_needs?
        self.complete? || (doc !="" && doc != "0"*11 && doc != "0"*14)
      end
  
      def complete?
        self.complete
      end
  
      def can_complete?
        raise "erros not empty" if self.errors.count>0
        old_complete = self.complete
    
        self.complete = true;
        ret = self.valid?
    
        self.complete = old_complete
        self.errors.clear
        ret
      end
    
      def a_customer?
        self.is_customer || (self.businesses.count>0)
      end

      def self.modules
        @@modules || []
      end

      def self.add_module(customer_module)
        @@modules = [] if @@modules.nil?
        @@modules << customer_module
      end
  
      def base_uri
        customer_path(self)
      end
  
    private
  
      def before_validation_completed
        (self.complete = self.can_complete?) if not self.complete
        true
      end
  end
end