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

ActiveRecord::Schema[7.2].define(version: 2024_09_20_063324) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "author"
    t.string "isbn"
    t.date "publish_date"
    t.text "genres"
    t.text "cover_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "club_id", null: false
    t.integer "user_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_chats_on_club_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "club_members", force: :cascade do |t|
    t.integer "club_id", null: false
    t.integer "user_id", null: false
    t.string "role"
    t.datetime "joined_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_members_on_club_id"
    t.index ["user_id"], name: "index_club_members_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "current_book_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_clubs_on_created_by_id"
    t.index ["current_book_id"], name: "index_clubs_on_current_book_id"
  end

  create_table "reading_list_books", force: :cascade do |t|
    t.integer "club_id", null: false
    t.integer "book_id", null: false
    t.string "status"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reading_list_books_on_book_id"
    t.index ["club_id"], name: "index_reading_list_books_on_club_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.integer "rating"
    t.text "review_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chats", "clubs"
  add_foreign_key "chats", "users"
  add_foreign_key "club_members", "clubs"
  add_foreign_key "club_members", "users"
  add_foreign_key "clubs", "created_bies"
  add_foreign_key "clubs", "current_books"
  add_foreign_key "reading_list_books", "books"
  add_foreign_key "reading_list_books", "clubs"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
