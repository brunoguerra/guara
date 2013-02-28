class CreateGuaraVacancies < ActiveRecord::Migration
  def change
    create_table :guara_vacancies do |t|
      t.references :process_instance

      t.timestamps
    end
    add_index :guara_vacancies, :process_instance_id
  end
end
