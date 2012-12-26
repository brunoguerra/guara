class AddEnabledToCities < ActiveRecord::Migration
  def change
    add_column :guara_cities, :enabled, :boolean
  end
end
