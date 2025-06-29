# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_19_191919) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "unaccent"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "master", default: false, null: false
    t.boolean "active", default: true, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["name"], name: "index_admins_on_name"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "bio"
    t.boolean "active", default: true, null: false
    t.string "provider"
    t.string "uid"
    t.string "cpf"
    t.string "phone"
    t.string "cep"
    t.string "city"
    t.string "state"
    t.text "address"
    t.string "formation"
    t.string "current_company"
    t.index ["cpf"], name: "index_clients_on_cpf", unique: true
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["name"], name: "index_clients_on_name"
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "course_classes", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_at", null: false
    t.date "end_at", null: false
    t.integer "available_slots"
    t.integer "subscription_status", default: 0
    t.text "schedule"
    t.boolean "active", default: true
    t.bigint "course_id", null: false
    t.bigint "instructor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "name"], name: "index_course_classes_on_course_id_and_name", unique: true
    t.index ["course_id"], name: "index_course_classes_on_course_id"
    t.index ["instructor_id", "start_at"], name: "index_course_classes_on_instructor_id_and_start_at"
    t.index ["instructor_id"], name: "index_course_classes_on_instructor_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_courses_on_name"
  end

  create_table "enrollment_drafts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "course_class_id", null: false
    t.string "current_step", default: "client"
    t.jsonb "client_data"
    t.jsonb "enrollment_data"
    t.jsonb "payment_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "course_class_id"], name: "index_enrollment_drafts_on_client_id_and_course_class_id", unique: true
    t.index ["client_id"], name: "index_enrollment_drafts_on_client_id"
    t.index ["course_class_id"], name: "index_enrollment_drafts_on_course_class_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "course_class_id", null: false
    t.text "notes"
    t.string "category"
    t.string "status", default: "pending"
    t.string "referral_source"
    t.boolean "previous_participation"
    t.boolean "terms_accepted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "course_class_id"], name: "index_enrollments_on_client_id_and_course_class_id", unique: true
    t.index ["client_id"], name: "index_enrollments_on_client_id"
    t.index ["course_class_id"], name: "index_enrollments_on_course_class_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.boolean "active", default: true, null: false
    t.text "resume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_instructors_on_email", unique: true
    t.index ["name"], name: "index_instructors_on_name"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "enrollment_id", null: false
    t.decimal "amount"
    t.string "status", default: "pending"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_payments_on_client_id"
    t.index ["enrollment_id"], name: "index_payments_on_enrollment_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "course_classes", "courses", on_delete: :restrict
  add_foreign_key "course_classes", "instructors", on_delete: :restrict
  add_foreign_key "enrollment_drafts", "clients"
  add_foreign_key "enrollment_drafts", "course_classes"
  add_foreign_key "enrollments", "clients"
  add_foreign_key "enrollments", "course_classes"
  add_foreign_key "payments", "clients"
  add_foreign_key "payments", "enrollments"
end
