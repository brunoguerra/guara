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

ActiveRecord::Schema.define(:version => 20121228190807) do

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

  create_table "guara_addresses", :force => true do |t|
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "address",          :limit => 120
    t.string   "complement",       :limit => 30
    t.string   "postal_code",      :limit => 20
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "guara_addresses", ["state_id", "city_id"], :name => "index_guara_addresses_on_state_id_and_city_id"

  create_table "guara_cities", :force => true do |t|
    t.string   "name",       :limit => 60
    t.integer  "state_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.boolean  "enabled"
  end

  add_index "guara_cities", ["state_id"], :name => "index_guara_cities_on_state_id"

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
    t.string   "name",                   :limit => 25
    t.string   "email",                  :limit => 100
    t.boolean  "enabled",                               :default => true
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "remember_token"
    t.boolean  "admin",                                 :default => false
    t.string   "encrypted_password",                    :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "primary_group_id"
    t.integer  "type_id",                               :default => 0,     :null => false
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
