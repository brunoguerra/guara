# This migration comes from guara_store (originally 20130118141441)
class AddEnabledAndPrimaryCategoryIdToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :enabled, :boolean
    add_column :spree_products, :primary_category_id, :integer
  end
end
