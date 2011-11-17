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

ActiveRecord::Schema.define(:version => 20110919214316) do

  create_table "bugs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finished"
  end

  create_table "counterpart_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "counterpart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counterparts", :force => true do |t|
    t.integer  "project_id"
    t.integer  "bearing"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "limit_products"
  end

  create_table "credit_historics", :force => true do |t|
    t.string   "historic_type"
    t.boolean  "validated"
    t.integer  "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title",                      :limit => 128
    t.integer  "wish_money"
    t.integer  "min_money"
    t.datetime "date_end_wish"
    t.boolean  "capital_stock_type"
    t.boolean  "personalized_reward"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "submited"
    t.boolean  "validated"
    t.string   "region"
    t.string   "pres_doc_path"
    t.integer  "progress"
    t.text     "description"
    t.string   "url_path"
    t.boolean  "blog_enabled"
    t.string   "project_image_file_name"
    t.string   "project_image_content_type"
    t.integer  "project_image_file_size"
    t.datetime "project_image_updated_at"
    t.string   "short_descr"
    t.text     "business_plan"
    t.string   "you_tube"
  end

  add_index "projects", ["title"], :name => "index_projects_on_title", :unique => true

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "user_type"
    t.string   "f_name"
    t.string   "l_name"
    t.datetime "birth_date"
    t.string   "birth_place"
    t.string   "nationality"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone_number"
    t.string   "web_site"
    t.string   "photo_path"
    t.boolean  "receive_newsletter",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"
    t.string   "country"
    t.integer  "credits"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["f_name"], :name => "index_users_on_f_name"
  add_index "users", ["l_name"], :name => "index_users_on_l_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["user_type"], :name => "index_users_on_user_type"

end
