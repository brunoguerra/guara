class CreateGuaraPlanContacts < ActiveRecord::Migration
  def change
    create_table :guara_plan_contacts do |t|
      t.string :subject
      t.date :date_start
      t.date :date_finish
      t.references :task_type
      t.references :user

      t.timestamps
    end
    add_index :guara_plan_contacts, :task_type_id
    add_index :guara_plan_contacts, :user_id
  end
end
