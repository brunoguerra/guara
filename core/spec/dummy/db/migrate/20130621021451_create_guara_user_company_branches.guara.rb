# This migration comes from guara (originally 20130620181208)
class CreateGuaraUserCompanyBranches < ActiveRecord::Migration
  def change
    create_table :guara_user_company_branches do |t|
      t.references :branch
      t.boolean :enabled

      t.timestamps
    end
    add_index :guara_user_company_branches, :branch_id
    
    add_column :guara_users, :primary_company_branch, :integer, :default => nil
  end
end
