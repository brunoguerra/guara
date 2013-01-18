# This migration comes from guara_crm (originally 20121104135014)
class GuaraCrm < ActiveRecord::Migration
  def up
    create_table :guara_customers do |t|
      t.string	:name	, :limit => 120, :null => false
      t.string	:doc	, :limit => 14
      t.string	:doc_rg	, :limit => 22
		
      t.string	:name_sec	, :limit => 120 #
      t.string	:address	, :limit => 150
      t.integer	:district_id
      t.integer	:city_id
      t.integer	:state_id
      t.string	:postal	  , :limit => 8
      t.text  	:notes
      t.date  	:birthday
		  
      t.string	:phone	        , :limit => 35
      t.string	:social_link	, :limit => 200
      t.string	:site	        , :limit => 200
      t.boolean	:is_customer	, :default => false
      #dont use field name type, its used for inharitance and crashs on restore
      #t.boolean	:type         , :default => true #legal entity or individual
      t.integer	:parent_id
      
      t.boolean :enabled, :default => true
      
      t.references :person, :polymorphic => true
      
      t.boolean :complete      
      t.float	:annual_revenue
      t.integer :external_key
      
      t.timestamps
    end
    
    
    create_table :guara_customer_pfs do |t|
      t.string	:gender             , :limit => 1
      t.integer :company
      t.string	:business_address   , :limit => 120
      t.string	:department         , :limit => 20
      t.string	:corporate_function , :limit => 20
      t.string	:cellphone          , :limit => 15
      t.string	:graduated          , :limit => 30
      t.timestamps 
    end
    
    create_table :guara_customer_pjs do |t|
      t.string	:fax	, :limit => 35
      t.integer	:total_employes	
      t.integer	:segment_id	
      t.integer	:activity_id
      t.float :annual_revenues
      
      t.timestamps
    end
    
    
    
    create_table   :guara_tasks do |t|
      t.string     :name, limit: 150
      t.references :interested, :polymorphic => true
      t.references :contact, :polymorphic => true
      t.datetime   :due_time
      t.datetime   :finish_time
      t.text	     :notes
      t.string     :description, :limit => 1000
      
      t.integer	:user_id
      t.integer	:status_id
      t.integer :type_id
      t.integer :assigned_id
      t.integer :resolution_id
      
      t.timestamps
    end
    
    add_index :guara_tasks, [:interested_id, :interested_type]
    add_index :guara_tasks, :status_id
    add_index :guara_tasks, :assigned_id
    add_index :guara_tasks, :type_id
    
    create_table :guara_customer_products do |t|
      t.integer	:costumer_id	
      t.integer	:product_id	
      t.date	:date	
      t.boolean	:used	, :default => true
      t.integer	:rate_id


      t.timestamps
    end
    
    
    create_table :guara_business_segments do |t|
      t.string :name, :limit => 100
      t.boolean :enabled,  :default => true

      t.timestamps
    end
    
    create_table :guara_business_activities do |t|
      t.string :name, :limit => 100
      t.boolean :enabled,  :default => true
      t.references :business_segment
      t.string :notes, :limit => 500
      t.timestamps
    end
    
    add_index :guara_business_activities, :business_segment_id
    
    
    create_table :guara_customer_activities do |t|
      t.integer :customer_pj_id
      t.integer :activity_id
      t.timestamps
    end
    
    create_table :guara_customer_segments do |t|
      t.integer :customer_pj_id
      t.integer :segment_id
      t.timestamps
    end
    
    create_table :guara_contacts do |t|
      t.references :customer
      t.string :name, limit: 150
      t.integer :department_id
      t.string :business_function
      t.string :phone
      t.string :cell
      t.string :birthday

      t.timestamps
    end
    
    add_index :guara_contacts, :customer_id
    add_index :guara_contacts, :department_id
    
    create_table :guara_system_task_status do |t|
      t.string :name
    end
    
    create_table :guara_system_task_resolutions do |t|
      t.string :name
    end
    
    
    create_table :guara_task_types do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
    
    create_table :guara_task_feedbacks do |t|
      t.integer :task_id
      t.datetime :date
      t.string :notes
      t.integer :user_id
      t.integer :status_id
      t.integer :resolution_id

      t.timestamps
    end
    
    
    
    
    
    
    create_table :guara_business_departments do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
    
    add_column :guara_customers, :other_contacts, :string, :limit => 70
    
    create_table :guara_company_businesses do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
    
    
    
    
    
    add_column :guara_task_types, :company_business_id, :integer
    add_index :guara_task_types, :company_business_id
    
    add_column :guara_users, :primary_company_business_id, :integer
    
    add_column :guara_system_task_resolutions, :parent_id, :integer
    
    
    create_table :guara_customer_has_customers do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
    
    create_table :guara_customer_pj_has_customers_pjs do |t|
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
    
    create_table :guara_customer_financials do |t|
      t.references :customer
      t.boolean  :billing_address_different
      t.integer  :contact_leader_id
      t.boolean :payment_pending
      t.string  :payment_pending_message, :limit => 500
      
      t.references :address
      
      t.string  :notes, :limit => 1000
      
      t.timestamps
    end
  end
end