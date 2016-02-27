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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160227215745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string   "type"
    t.datetime "date"
    t.integer  "employee_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "salary_old"
    t.integer  "salary_new"
    t.integer  "job_id_old"
    t.integer  "job_id_new"
    t.integer  "department_id_old"
    t.integer  "department_id_new"
  end

  add_index "actions", ["department_id_new"], name: "index_actions_on_department_id_new", using: :btree
  add_index "actions", ["department_id_old"], name: "index_actions_on_department_id_old", using: :btree
  add_index "actions", ["employee_id"], name: "index_actions_on_employee_id", using: :btree
  add_index "actions", ["job_id_new"], name: "index_actions_on_job_id_new", using: :btree
  add_index "actions", ["job_id_old"], name: "index_actions_on_job_id_old", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "salary"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "job_id"
    t.integer  "department_id"
    t.boolean  "is_fired"
    t.text     "dismissal_reason"
  end

  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree
  add_index "employees", ["job_id"], name: "index_employees_on_job_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "actions", "employees"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "jobs"
end
