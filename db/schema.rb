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

ActiveRecord::Schema.define(version: 2019_04_27_134221) do

  create_table "completed_courses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_completed_courses_on_course_id"
    t.index ["user_id"], name: "index_completed_courses_on_user_id"
  end

  create_table "course_requirements", force: :cascade do |t|
    t.integer "course_id"
    t.integer "requirement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_requirements_on_course_id"
    t.index ["requirement_id"], name: "index_course_requirements_on_requirement_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_courses_on_ancestry"
  end

  create_table "declared_programs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["major_id"], name: "index_declared_programs_on_major_id"
    t.index ["user_id"], name: "index_declared_programs_on_user_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "requirements", force: :cascade do |t|
    t.string "name"
    t.integer "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "num_required"
    t.index ["major_id"], name: "index_requirements_on_major_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "faculty", default: false
    t.string "firstname"
    t.string "lastname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
