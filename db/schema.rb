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

ActiveRecord::Schema.define(version: 2020_05_22_182418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "adopter_addresses", force: :cascade do |t|
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.string "street_line_1"
    t.string "street_line_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_adopter_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "adopter_profiles", force: :cascade do |t|
    t.string "pronoun"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "family_status"
    t.string "phone_number"
    t.jsonb "preferences", default: {}, null: false
    t.boolean "terms"
    t.boolean "home_visit_agreement"
    t.boolean "adoption_fee_agreement"
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_adopter_profiles_on_user_id"
  end

  create_table "co_adopters", force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.string "birthday"
    t.string "first_name"
    t.string "last_name"
    t.bigint "adopter_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adopter_profile_id"], name: "index_co_adopters_on_adopter_profile_id"
  end

  create_table "employments", force: :cascade do |t|
    t.string "employmentable_type", null: false
    t.bigint "employmentable_id", null: false
    t.string "status"
    t.string "years"
    t.string "company"
    t.string "pet_costs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employmentable_type", "employmentable_id"], name: "index_employments_on_employmentable_type_and_employmentable_id"
  end

  create_table "favorite_pets", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id", "user_id"], name: "index_favorite_pets_on_pet_id_and_user_id"
    t.index ["pet_id"], name: "index_favorite_pets_on_pet_id"
    t.index ["user_id", "pet_id"], name: "index_favorite_pets_on_user_id_and_pet_id"
    t.index ["user_id"], name: "index_favorite_pets_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "inqueries", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "city"
    t.string "state"
    t.text "reasons"
    t.bigint "pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_inqueries_on_pet_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.string "senderable_type", null: false
    t.bigint "senderable_id", null: false
    t.bigint "pet_application_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_application_id"], name: "index_messages_on_pet_application_id"
    t.index ["senderable_type", "senderable_id"], name: "index_messages_on_senderable_type_and_senderable_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organization_addresses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.boolean "main_location"
    t.string "type"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_organization_addresses_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "director"
    t.string "description"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "5013c"
    t.boolean "sheltered"
    t.boolean "foster_based"
    t.string "url"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pet_applications", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "adopter_profile_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "favorite", default: false
    t.bigint "organization_id"
    t.json "rejection_details"
    t.datetime "rejected_at"
    t.index ["adopter_profile_id"], name: "index_pet_applications_on_adopter_profile_id"
    t.index ["organization_id"], name: "index_pet_applications_on_organization_id"
    t.index ["pet_id"], name: "index_pet_applications_on_pet_id"
  end

  create_table "pet_infos", force: :cascade do |t|
    t.jsonb "home"
    t.jsonb "animal_history"
    t.jsonb "lifestyle"
    t.jsonb "personal"
    t.jsonb "veterinarian_extra"
    t.bigint "adopter_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adopter_profile_id"], name: "index_pet_infos_on_adopter_profile_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "external_id"
    t.string "external_type"
    t.string "pet_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", null: false
    t.string "microchip_provider"
    t.string "microchip_number"
    t.string "housed"
    t.string "breed", null: false
    t.string "second_breed"
    t.string "sex", null: false
    t.string "size", null: false
    t.string "age", null: false
    t.text "description", null: false
    t.text "medical_history"
    t.text "foster_family"
    t.boolean "public"
    t.boolean "mix_breed"
    t.jsonb "personality", default: "{}", null: false
    t.string "slug"
    t.string "short_url"
    t.string "status", default: "created"
    t.integer "reason_code"
    t.bigint "organization_id"
    t.integer "added_by_id"
    t.string "location", default: "", null: false
    t.index ["external_type"], name: "index_pets_on_external_type"
    t.index ["organization_id"], name: "index_pets_on_organization_id"
    t.index ["pet_type"], name: "index_pets_on_pet_type"
    t.index ["slug"], name: "index_pets_on_slug", unique: true
  end

  create_table "references", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "relationship"
    t.bigint "adopter_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adopter_profile_id"], name: "index_references_on_adopter_profile_id"
  end

  create_table "rescuer_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "title"
    t.string "type"
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_rescuer_profiles_on_organization_id"
    t.index ["user_id"], name: "index_rescuer_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "type", null: false
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.jsonb "settings"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["type"], name: "index_users_on_type"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "veterinarians", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.bigint "adopter_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adopter_profile_id"], name: "index_veterinarians_on_adopter_profile_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adopter_profiles", "users"
  add_foreign_key "co_adopters", "adopter_profiles"
  add_foreign_key "favorite_pets", "pets"
  add_foreign_key "favorite_pets", "users"
  add_foreign_key "messages", "pet_applications"
  add_foreign_key "organization_addresses", "organizations"
  add_foreign_key "pet_applications", "adopter_profiles"
  add_foreign_key "pet_applications", "pets"
  add_foreign_key "pet_infos", "adopter_profiles"
  add_foreign_key "pets", "organizations"
  add_foreign_key "references", "adopter_profiles"
  add_foreign_key "rescuer_profiles", "organizations"
  add_foreign_key "rescuer_profiles", "users"
  add_foreign_key "veterinarians", "adopter_profiles"
end
