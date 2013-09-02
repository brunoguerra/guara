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

ActiveRecord::Schema.define(:version => 20130901201833) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "guara_active_crm_scheduled_classifieds", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_active_crm_scheduled_contacts", :force => true do |t|
    t.integer  "deal_id",                         :null => false
    t.integer  "user_id",                         :null => false
    t.integer  "contact_id"
    t.integer  "classified_id"
    t.text     "activity",                        :null => false
    t.integer  "result",                          :null => false
    t.datetime "scheduled_at"
    t.boolean  "enabled",       :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "guara_active_crm_scheduled_contacts", ["classified_id"], :name => "index_guara_active_crm_scheduled_contacts_on_classified_id"
  add_index "guara_active_crm_scheduled_contacts", ["contact_id"], :name => "index_guara_active_crm_scheduled_contacts_on_contact_id"
  add_index "guara_active_crm_scheduled_contacts", ["deal_id"], :name => "index_guara_active_crm_scheduled_contacts_on_deal_id"
  add_index "guara_active_crm_scheduled_contacts", ["scheduled_at"], :name => "index_guara_active_crm_scheduled_contacts_on_scheduled_at"

  create_table "guara_active_crm_scheduled_deals", :force => true do |t|
    t.integer  "scheduled_id"
    t.integer  "customer_id"
    t.datetime "date_start"
    t.datetime "date_finish"
    t.integer  "group_id"
    t.boolean  "closed",       :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "guara_active_crm_scheduled_deals", ["customer_id"], :name => "index_guara_active_crm_scheduled_deals_on_customer_id"
  add_index "guara_active_crm_scheduled_deals", ["scheduled_id"], :name => "index_guara_active_crm_scheduled_deals_on_scheduled_id"

  create_table "guara_active_crm_scheduled_groups", :force => true do |t|
    t.string   "business_activities"
    t.string   "business_segments"
    t.integer  "employes_min"
    t.integer  "employes_max"
    t.string   "name_contains"
    t.string   "district_contains"
    t.string   "doc_equals"
    t.string   "pair_or_odd",         :limit => 1
    t.integer  "finished_id"
    t.integer  "scheduled_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "guara_active_crm_scheduled_ignoreds", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "guara_active_crm_scheduleds", :force => true do |t|
    t.string   "subject"
    t.date     "date_start"
    t.date     "date_finish"
    t.integer  "task_type_id"
    t.integer  "user_id"
    t.integer  "status",       :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "guara_active_crm_scheduleds", ["task_type_id"], :name => "index_guara_active_crm_scheduleds_on_task_type_id"
  add_index "guara_active_crm_scheduleds", ["user_id"], :name => "index_guara_active_crm_scheduleds_on_user_id"

  create_table "guara_addresses", :force => true do |t|
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "address",          :limit => 120
    t.string   "number",           :limit => 15
    t.string   "complement",       :limit => 30
    t.string   "postal_code",      :limit => 20
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "guara_addresses", ["state_id", "city_id"], :name => "index_guara_addresses_on_state_id_and_city_id"

  create_table "guara_business_activities", :force => true do |t|
    t.string   "name",                :limit => 100
    t.boolean  "enabled",                            :default => true
    t.integer  "business_segment_id"
    t.string   "notes",               :limit => 500
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "guara_business_activities", ["business_segment_id"], :name => "index_guara_business_activities_on_business_segment_id"

  create_table "guara_business_departments", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_business_segments", :force => true do |t|
    t.string   "name",       :limit => 100
    t.boolean  "enabled",                   :default => true
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "guara_cities", :force => true do |t|
    t.string   "name",       :limit => 60
    t.integer  "state_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.boolean  "enabled"
  end

  add_index "guara_cities", ["state_id"], :name => "index_guara_cities_on_state_id"

  create_table "guara_company_branches", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.integer  "address_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "guara_company_branches", ["address_id"], :name => "index_guara_company_branches_on_address_id"

  create_table "guara_company_branches_users", :force => true do |t|
    t.integer "company_branch_id"
    t.integer "user_id"
    t.boolean "enabled"
  end

  add_index "guara_company_branches_users", ["company_branch_id"], :name => "index_guara_company_branches_users_on_company_branch_id"
  add_index "guara_company_branches_users", ["user_id"], :name => "index_guara_company_branches_users_on_user_id"

  create_table "guara_company_businesses", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_contacts", :force => true do |t|
    t.integer  "person_id"
    t.string   "name",              :limit => 150
    t.integer  "department_id"
    t.string   "business_function"
    t.string   "phone"
    t.string   "cell"
    t.string   "birthday"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "guara_contacts", ["department_id"], :name => "index_guara_contacts_on_department_id"
  add_index "guara_contacts", ["person_id"], :name => "index_guara_contacts_on_person_id"

  create_table "guara_customer_activities", :force => true do |t|
    t.integer  "customer_pj_id"
    t.integer  "activity_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "guara_customer_financials", :force => true do |t|
    t.integer  "person_id"
    t.boolean  "billing_address_different"
    t.integer  "contact_leader_id"
    t.boolean  "payment_pending"
    t.string   "payment_pending_message",   :limit => 500
    t.integer  "address_id"
    t.string   "notes",                     :limit => 1000
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "guara_customer_has_customers", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_customer_pfs", :force => true do |t|
    t.string   "gender",             :limit => 1
    t.string   "company"
    t.string   "business_address",   :limit => 120
    t.string   "department",         :limit => 20
    t.string   "corporate_function", :limit => 20
    t.string   "cellphone",          :limit => 15
    t.string   "graduated",          :limit => 30
    t.integer  "civil_state",        :limit => 2
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "guara_customer_pj_has_customers_pjs", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_customer_pjs", :force => true do |t|
    t.string   "fax",             :limit => 35
    t.integer  "total_employes"
    t.integer  "segment_id"
    t.integer  "activity_id"
    t.float    "annual_revenues"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "guara_customer_products", :force => true do |t|
    t.integer  "costumer_id"
    t.integer  "product_id"
    t.date     "date"
    t.boolean  "used",        :default => true
    t.integer  "rate_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "guara_customer_segments", :force => true do |t|
    t.integer  "customer_pj_id"
    t.integer  "segment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "guara_districts", :force => true do |t|
    t.string   "name",       :limit => 60
    t.integer  "city_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "guara_districts", ["city_id"], :name => "index_guara_districts_on_city_id"

  create_table "guara_emails", :force => true do |t|
    t.integer  "customer_id"
    t.string   "email",          :limit => 120
    t.boolean  "infos",                         :default => true
    t.boolean  "private",                       :default => true
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "guara_microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "guara_microposts", ["user_id", "created_at"], :name => "index_guara_microposts_on_user_id_and_created_at"

  create_table "guara_people", :force => true do |t|
    t.string   "name",           :limit => 120,                    :null => false
    t.string   "doc",            :limit => 14
    t.string   "doc_rg",         :limit => 22
    t.string   "name_sec",       :limit => 120
    t.string   "address",        :limit => 150
    t.integer  "district_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "postal",         :limit => 8
    t.text     "notes"
    t.date     "birthday"
    t.string   "phone",          :limit => 35
    t.string   "social_link",    :limit => 200
    t.string   "site",           :limit => 200
    t.boolean  "is_customer",                   :default => false
    t.integer  "parent_id"
    t.boolean  "enabled",                       :default => true
    t.integer  "customer_id"
    t.string   "customer_type"
    t.boolean  "complete"
    t.float    "annual_revenue"
    t.integer  "external_key"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "other_contacts", :limit => 70
    t.string   "number"
  end

  create_table "guara_phones", :force => true do |t|
    t.string   "phone"
    t.integer  "callable_id"
    t.string   "callable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "guara_phones", ["callable_id"], :name => "index_guara_phones_on_callable_id"

  create_table "guara_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "guara_relationships", ["followed_id"], :name => "index_guara_relationships_on_followed_id"
  add_index "guara_relationships", ["follower_id", "followed_id"], :name => "index_guara_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "guara_relationships", ["follower_id"], :name => "index_guara_relationships_on_follower_id"

  create_table "guara_states", :force => true do |t|
    t.string   "name",       :limit => 30
    t.string   "acronym",    :limit => 2
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "guara_system_abilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_system_extensions", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_system_modules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_system_preferences", :force => true do |t|
    t.string   "property"
    t.string   "value"
    t.string   "default"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guara_system_task_resolutions", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "guara_system_task_status", :force => true do |t|
    t.string "name"
  end

  create_table "guara_task_feedbacks", :force => true do |t|
    t.integer  "task_id"
    t.datetime "date"
    t.string   "notes"
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "resolution_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "guara_task_types", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "company_business_id"
  end

  add_index "guara_task_types", ["company_business_id"], :name => "index_guara_task_types_on_company_business_id"

  create_table "guara_tasks", :force => true do |t|
    t.string   "name",            :limit => 150
    t.integer  "interested_id"
    t.string   "interested_type"
    t.integer  "contact_id"
    t.string   "contact_type"
    t.datetime "due_time"
    t.datetime "finish_time"
    t.text     "notes"
    t.string   "description",     :limit => 1000
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "type_id"
    t.integer  "assigned_id"
    t.integer  "resolution_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "guara_tasks", ["assigned_id"], :name => "index_guara_tasks_on_assigned_id"
  add_index "guara_tasks", ["interested_id", "interested_type"], :name => "index_guara_tasks_on_interested_id_and_interested_type"
  add_index "guara_tasks", ["status_id"], :name => "index_guara_tasks_on_status_id"
  add_index "guara_tasks", ["type_id"], :name => "index_guara_tasks_on_type_id"

  create_table "guara_user_abilities", :force => true do |t|
    t.integer  "module_id"
    t.integer  "ability_id"
    t.integer  "skilled_id"
    t.string   "skilled_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "guara_user_groups", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled",    :default => true
    t.boolean  "system",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "guara_users", :force => true do |t|
    t.string   "name",                        :limit => 25
    t.string   "email",                       :limit => 100
    t.boolean  "enabled",                                    :default => true
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.string   "remember_token"
    t.boolean  "admin",                                      :default => false
    t.string   "encrypted_password",                         :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "primary_group_id"
    t.integer  "type_id",                                    :default => 0,     :null => false
    t.integer  "primary_company_branch_id"
    t.integer  "primary_company_business_id"
  end

  add_index "guara_users", ["email"], :name => "index_guara_users_on_email", :unique => true
  add_index "guara_users", ["primary_group_id"], :name => "index_guara_users_on_primary_group_id"
  add_index "guara_users", ["remember_token"], :name => "index_guara_users_on_remember_token"
  add_index "guara_users", ["reset_password_token"], :name => "index_guara_users_on_reset_password_token", :unique => true

  create_table "guara_users_has_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "guara_users_has_groups", ["user_group_id"], :name => "index_guara_users_has_groups_on_user_group_id"
  add_index "guara_users_has_groups", ["user_id", "user_group_id"], :name => "index_guara_users_has_groups_on_user_id_and_user_group_id", :unique => true
  add_index "guara_users_has_groups", ["user_id"], :name => "index_guara_users_has_groups_on_user_id"

end
