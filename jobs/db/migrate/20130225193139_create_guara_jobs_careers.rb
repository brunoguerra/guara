class CreateGuaraJobsCareers < ActiveRecord::Migration
  def change
    create_table :guara_jobs_careers do |t|

      t.string :role
      t.date :date_admission
      t.date :date_resignation
      t.decimal :salary, :precision => 10, :scale => 2, :default => 0
      t.text :activities
      
      t.references :professional_experience

      t.timestamps
    end
  end
end
