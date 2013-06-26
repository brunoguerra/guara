# This migration comes from guara (originally 20130620181038)
class CreateGuaraCompanyBranches < ActiveRecord::Migration
  def change
    create_table :guara_company_branches do |t|
      t.string :name
      t.boolean :enabled
      t.references :address
      t.timestamps
    end
    add_index :guara_company_branches, :address_id
  end
end
