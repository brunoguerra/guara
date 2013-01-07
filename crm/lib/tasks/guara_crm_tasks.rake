# encoding: utf-8
namespace :guara do
  namespace :crm do
    
    task seeds: :environment do
      Guara::Crm::Engine.load_seed
    end
    
    desc "Sample CRM Data"
    task sample: :environment do
      Customer.all.each { |u| u.destroy_fully }
      logger.info "Customers Destroyed"
  
      #Customer APPLE
      apple = Factory(:customer_pj, customer: Factory(:customer, name: "Apple")).customer

      logger.info "Customer Eggs Created"
  
      # Business Department
      business_department_adm = BusinessDepartment.all[0]
      business_department_prd = BusinessDepartment.all[1]
      
      2.times { Factory(:contact, customer: apple, department: business_department_adm) }
      4.times { Factory(:contact, customer: apple, department: business_department_prd) }

      logger.info "Contacts Createds"
  
      #Customer
      5.times { Factory(:customer_pj) }
  
      logger.info "5 Customers created"
    end
    
    desc "Fill database with sample data"
    task populate_test: :environment do 
      FileTest.exist? File.dirname(__FILE__) + '/../../spec/factories.rb'
      require File.dirname(__FILE__) + '/../../spec/factories.rb'
      5.times { Factory(:customer_pj) }
    end
    
  end
end