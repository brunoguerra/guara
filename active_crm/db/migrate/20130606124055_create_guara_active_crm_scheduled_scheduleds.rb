class CreateGuaraActiveCrmScheduleds < ActiveRecord::Migration
  def change
    create_table :guara_active_crm_scheduled_scheduleds do |t|
      t.string :subject
      t.date :date_start
      t.date :date_finish
      t.references :task_type
      t.references :user
      t.integer :status

      t.timestamps
    end
    add_index :guara_active_crm_scheduled_scheduleds, :task_type_id
    add_index :guara_active_crm_scheduled_scheduleds, :user_id
  end
end
