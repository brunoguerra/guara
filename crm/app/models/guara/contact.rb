module Guara
  class Contact < ActiveRecord::Base
    attr_accessible :name, :birthday, :business_function, :department, :department_id,
                    :phone, :cell, :customer, :emails, :emails_attributes, :emails_concat
  
    #=========================== associations <--------------------------------------------
    belongs_to :customer, :foreign_key => "person_id"
    belongs_to :person
    belongs_to :department, class_name: "BusinessDepartment"
    has_many :emails, :as => :emailable, dependent: :destroy, :extend => Guara

    #============================ 
  
    accepts_nested_attributes_for :emails, :reject_if => lambda { |a| a[:email].blank? }, :allow_destroy => true

    #=========================== validations <--------------------------------------------
    validates :name, :presence => true, length: { maximum: 150 }
    validates :person_id, :presence => true
    validates_uniqueness_of :name, :scope => [:person_id, :business_function]

    #=========================== scopes <--------------------------------------------
    default_scope includes(:department).order("guara_business_departments.name, guara_contacts.name")
    
    #=========================== search <--------------------------------------------  

    scope :with_department_name, lambda {
      select('id, concat(guara_business_departments.name, " - ", guara_contacts.name) as name')
    }
  
    def self.to_csv(records = nil, attributes = nil, options = {col_sep: ';', encoding: "cp1258"})

      person_columns = [:id, :name, :name_sec, :emails, :doc, :doc_rg, :address, :district_id, :city_id, :state_id, :postal, :notes, :birthday, :phone, :social_link, :site, :is_customer, :parent_id, :enabled, :customer_id, :customer_type, :complete, :annual_revenue, :external_key, :created_at, :updated_at, :other_contacts, :number]

      records ||= all
      columns = (attributes.map(&:to_s) || column_names)
      CSV.generate(options) do |csv|
        if options[:with_title]
          titles = (options[:titles] || columns)
          titles << person_columns if (columns.include? "person")
          csv <<  titles
        end

        records.each do |contact|
          values = contact.attributes.values_at(*columns)
          values[columns.index("emails")] = contact.emails.all.map(&:email).join(",") if columns.include? "emails"
          values += contact.person.to_csv(person_columns) if columns.include? "person"
          csv << values
        end
      end
    end
  
    def self.search_by_name(results, name)
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
        logger.debug results
        ret = results.where(conditions)
      else
        []
      end
    
    end
  
    def self.search_by_department
      @contacts = @customer.contacts.where( @selected_department ? ({ department_id: @selected_department }) : "1=1")
    end
  
    def emails_concat
      emails.map { |e| e.email }.join(", ")
    end
    
    def emails_concat=(emails_concated)
      if !emails_concated.equal?(self.emails_concat)
        emails_arr = emails_concated.split(",")
        self.emails = emails_arr.map {|email| Email.new(:email => email.strip)}
      end
    end

    def group=(group)
      @scheduled = group.scheduled
      @group = group
    end
  end
end