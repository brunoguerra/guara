class AddEnabledToCities < ActiveRecord::Migration
  def change
    add_column :cities, :enabled, :boolean
  end
end
