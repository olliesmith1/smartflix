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

ActiveRecord::Schema.define(version: 2021_12_15_163854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "external_ratings", force: :cascade do |t|
    t.integer "movie_id"
    t.float "imdb_rating"
    t.float "rotten_tomatoes_rating"
    t.float "metacritic_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movies_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year"
    t.string "rated"
    t.string "released"
    t.string "runtime"
    t.string "genre"
    t.string "director"
    t.string "writer"
    t.string "actors"
    t.string "plot"
    t.string "language"
    t.string "country"
    t.string "awards"
    t.string "poster"
    t.string "ratings"
    t.string "metascore"
    t.string "imdb_rating"
    t.string "imdb_votes"
    t.string "imdb_id"
    t.string "type"
    t.string "dvd"
    t.string "box_office"
    t.string "production"
    t.string "website"
    t.string "response"
  end

end
