module Guara
  class Contact < ActiveRecord::Base
    attr_accessible :name, :birthday, :business_function, :department, :department_id,
                    :phone, :cell, :customer, :emails
  
    #=========================== associations <--------------------------------------------
    belongs_to :customer
    belongs_to :department, class_name: "BusinessDepartment"
    has_many :emails, :as => :emailable, dependent: :destroy

    #============================ 
  
    accepts_nested_attributes_for :emails, :reject_if => lambda { |a| a[:email].blank? }, :allow_destroy => true

    #=========================== validations <--------------------------------------------
    validates :name, :presence => true, length: { maximum: 150 }
    validates :customer_id, :presence => true
    validates_uniqueness_of :name, :scope => [:customer_id, :business_function]

    #=========================== search <--------------------------------------------  
  
    def self.search_by_params(results=nil, query)
    
      results = self.send(:relation) if results.nil?
      where = {}
    
      query.each do |k,v|
      
        next if v.nil?
      
        if k=="name"
          where.merge! 'upper(name) LIKE ?', "%#{name}%"
        elsif self.instance_methods.include?("#{k}_id".to_sym)
          where.merge! :"#{k}_id" => v
        elsif self.instance_methods.include?(k.to_sym)
          where.merge! k.to_sym => v
        end
      end
    
      results.where(where)
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
  
  end
end