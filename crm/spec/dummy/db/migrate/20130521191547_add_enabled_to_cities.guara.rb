# This migration comes from guara (originally 20121103183646)
class AddEnabledToCities < ActiveRecord::Migration
  def change
    add_column :guara_cities, :enabled, :boolean
  end
end
