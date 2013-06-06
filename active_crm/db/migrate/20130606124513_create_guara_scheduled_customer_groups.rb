class CreateGuaraScheduledCustomerGroups < ActiveRecord::Migration
  def change
    create_table :guara_scheduled_customer_groups do |t|
      t.string :business_activities
      t.string :business_segments
      t.integer :employes_min
      t.integer :employes_max

      t.timestamps
    end
  end
end
