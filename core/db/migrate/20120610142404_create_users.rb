class CreateUsers < ActiveRecord::Migration
  def change
    create_table :guara_users do |t|
      t.string :name, :limit => 100
      t.string :email, :limit => 100
      t.boolean :enabled, :default => true
      t.timestamps
    end
  end
end
