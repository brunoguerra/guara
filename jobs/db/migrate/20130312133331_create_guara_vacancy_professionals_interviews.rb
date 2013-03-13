class CreateGuaraVacancyProfessionalsInterviews < ActiveRecord::Migration
  def change
    create_table :guara_vacnacy_professionals_interviews do |t|
      t.references :vacancy_scheduling_professsional
      t.datetime :date
      t.references :process_instance
      t.references :step
      
      t.timestamps
    end
    add_index :guara_vacnacy_professionals_interviews, :vacancy_scheduling_professsional_id, name: "vacancy_schd_prf_id"
  end
end
