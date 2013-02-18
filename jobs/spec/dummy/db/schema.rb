# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130207191752) do

  create_table "guara_business_actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_jobs_abilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_jobs_formations", :force => true do |t|
    t.string   "level_education"
    t.string   "course"
    t.string   "situation"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "guara_jobs_vacancy_specifications", :force => true do |t|
    t.decimal  "salary_requirements", :precision => 10, :scale => 2, :default => 0.0
    t.string   "business_action"
    t.string   "role"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  create_table "guara_jobs_level_educations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_jobs_professional_experiences", :force => true do |t|
    t.string   "company_name"
    t.string   "role"
    t.date     "date_admission"
    t.date     "date_resignation"
    t.decimal  "salary",           :precision => 10, :scale => 2, :default => 0.0
    t.text     "activities"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "guara_jobs_professional_formations", :force => true do |t|
    t.integer  "professional_id"
    t.integer  "formation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "guara_jobs_professional_professional_experiences", :force => true do |t|
    t.integer  "professional_id"
    t.integer  "professional_experience_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "guara_jobs_professionals", :force => true do |t|
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_jobs_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
