# This migration comes from guara (originally 20120621100557)
class CreateEmails < ActiveRecord::Migration
  def change
    create_table :guara_emails do |t|
      t.integer	:customer_id	
      t.string	:email	, :limit => 120
      t.boolean	:infos	, :default => true
      t.boolean	:private	, :default => true
      t.references :emailable, :polymorphic => true
      
      t.timestamps
    end
  end
end
