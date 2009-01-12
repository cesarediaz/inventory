# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090112185459) do

  create_table "cds", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.boolean  "writable"
    t.integer  "computer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mark_id"
  end

  create_table "computers", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "mac"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "available",                :default => true
    t.integer  "place_id"
    t.boolean  "is_part_of_a_workstation", :default => false
  end

  create_table "dvds", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.boolean  "writable"
    t.integer  "computer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mark_id"
  end

  create_table "harddisks", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.integer  "computer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mark_id"
  end

  create_table "marks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memories", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "computer_id"
    t.integer  "mark_id"
  end

  create_table "mother_boards", :force => true do |t|
    t.string   "title"
    t.string   "serialnumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "computer_id"
    t.integer  "mark_id"
  end

  create_table "places", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "printers", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.integer  "mark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.boolean  "is_part_of_a_workstation", :default => false
  end

  create_table "screens", :force => true do |t|
    t.string   "model"
    t.string   "serialnumber"
    t.integer  "mark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.boolean  "is_part_of_a_workstation", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "workstations", :force => true do |t|
    t.integer  "printer_id"
    t.integer  "computer_id", :null => false
    t.integer  "screen_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
