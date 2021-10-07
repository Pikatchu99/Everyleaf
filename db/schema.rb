# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2021_10_07_094444) do
=======
ActiveRecord::Schema.define(version: 2021_10_07_064337) do
>>>>>>> 122a47303e4717c5af17a1a4beb902d40c4f110f

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labelings", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "label_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["label_id"], name: "index_labelings_on_label_id"
    t.index ["task_id"], name: "index_labelings_on_task_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
<<<<<<< HEAD
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
=======
    t.bigint "task_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["task_id"], name: "index_labels_on_task_id"
    t.index ["user_id"], name: "index_labels_on_user_id"
>>>>>>> 122a47303e4717c5af17a1a4beb902d40c4f110f
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "details", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expired_at", default: "2021-10-07 15:29:39", null: false
    t.string "status"
    t.integer "priority"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin"
  end

  add_foreign_key "labelings", "labels"
  add_foreign_key "labelings", "tasks"
  add_foreign_key "tasks", "users"
end
