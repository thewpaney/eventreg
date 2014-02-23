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

ActiveRecord::Schema.define(version: 20140223231424) do

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "students", force: true do |t|
    t.integer "number"
    t.string  "full"
    t.string  "gender"
    t.string  "grade"
    t.string  "year"
    t.string  "email"
    t.string  "prefix"
    t.string  "rw"
    t.string  "rw_number"
    t.string  "rw_teacher"
    t.string  "advisement"
  end

  create_table "students_workshops", force: true do |t|
    t.integer "student_id"
    t.integer "workshop_id"
  end

  add_index "students_workshops", ["student_id", "workshop_id"], name: "index_students_workshops_on_student_id_and_workshop_id", using: :btree
  add_index "students_workshops", ["workshop_id", "student_id"], name: "index_students_workshops_on_workshop_id_and_student_id", using: :btree

  create_table "teachers", force: true do |t|
    t.string "number"
    t.string "name"
    t.string "email"
    t.string "prefix"
    t.string "division"
  end

  create_table "teachers_workshops", force: true do |t|
    t.integer "teacher_id"
    t.integer "workshop_id"
  end

  add_index "teachers_workshops", ["teacher_id", "workshop_id"], name: "index_teachers_workshops_on_teacher_id_and_workshop_id", using: :btree
  add_index "teachers_workshops", ["workshop_id", "teacher_id"], name: "index_teachers_workshops_on_workshop_id_and_teacher_id", using: :btree

  create_table "workshops", force: true do |t|
    t.string  "name"
    t.string  "presentor"
    t.text    "description"
    t.integer "session"
    t.string  "tlimit"
    t.string  "slimit"
    t.string  "room"
    t.integer "ttaken"
    t.integer "staken"
    t.integer "percentage"
  end

end
