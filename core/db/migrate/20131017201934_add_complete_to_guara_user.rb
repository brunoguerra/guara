class AddCompleteToGuaraUser < ActiveRecord::Migration
  def change
    add_column :guara_users, :complete, :boolean
  end
end
