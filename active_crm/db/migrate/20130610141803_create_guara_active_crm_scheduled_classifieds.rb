class CreateGuaraActiveCrmScheduledClassifieds < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_classifieds do |t|
      t.string :name
      t.boolean :enable

      t.timestamps
    end
  end
end
