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

ActiveRecord::Schema.define(version: 20170301044327) do

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "students", force: :cascade do |t|
    t.integer "number",          limit: 4
    t.string  "full",            limit: 255
    t.string  "gender",          limit: 255
    t.string  "grade",           limit: 255
    t.string  "year",            limit: 255
    t.string  "email",           limit: 255
    t.string  "prefix",          limit: 255
    t.string  "rw",              limit: 255
    t.string  "rw_number",       limit: 255
    t.string  "rw_teacher",      limit: 255
    t.string  "advisement",      limit: 255
    t.string  "advisement_name", limit: 255
  end

  create_table "students_workshops", force: :cascade do |t|
    t.integer "student_id",  limit: 4
    t.integer "workshop_id", limit: 4
  end

  add_index "students_workshops", ["student_id", "workshop_id"], name: "index_students_workshops_on_student_id_and_workshop_id", using: :btree
  add_index "students_workshops", ["workshop_id", "student_id"], name: "index_students_workshops_on_workshop_id_and_student_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.string "number",   limit: 255
    t.string "name",     limit: 255
    t.string "email",    limit: 255
    t.string "prefix",   limit: 255
    t.string "division", limit: 255
  end

  create_table "teachers_workshops", force: :cascade do |t|
    t.integer "teacher_id",  limit: 4
    t.integer "workshop_id", limit: 4
  end

  add_index "teachers_workshops", ["teacher_id", "workshop_id"], name: "index_teachers_workshops_on_teacher_id_and_workshop_id", using: :btree
  add_index "teachers_workshops", ["workshop_id", "teacher_id"], name: "index_teachers_workshops_on_workshop_id_and_teacher_id", using: :btree

  create_table "workshops", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "presentor",   limit: 255
    t.text    "description", limit: 65535
    t.integer "session",     limit: 4
    t.string  "tlimit",      limit: 255
    t.string  "slimit",      limit: 255
    t.string  "room",        limit: 255
    t.integer "ttaken",      limit: 4
    t.integer "staken",      limit: 4
    t.integer "percentage",  limit: 4
    t.integer "overflow",    limit: 4
    t.integer "twofer_ref",  limit: 4
  end

end
