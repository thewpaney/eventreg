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

ActiveRecord::Schema.define(:version => 20120922182759) do

  create_table "events", :force => true do |t|
    t.string  "name"
    t.integer "capacity"
  end

  create_table "users", :force => true do |t|
    t.integer "student_id"
    t.string  "login"
    t.string  "first"
    t.string  "last"
    t.integer "grade"
    t.integer "event_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["student_id"], :name => "index_users_on_student_id", :unique => true

end
