# This migration comes from guara (originally 20130620181208)
class CreateGuaraCompanyBranchesUsers < ActiveRecord::Migration
  def change
    create_table :guara_company_branches_users do |t|
      t.references :company_branch
      t.references :user
      t.boolean :enabled
    end
    add_index :guara_company_branches_users, :user_id
    add_index :guara_company_branches_users, :company_branch_id
    
    add_column :guara_users, :primary_company_branch_id, :integer, :default => nil
  end
end
