# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

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
    t.string "avatar"
    t.boolean "active", default: true, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["name"], name: "index_admins_on_name"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end
end
