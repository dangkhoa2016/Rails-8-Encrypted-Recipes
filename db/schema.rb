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

ActiveRecord::Schema[8.0].define(version: 2025_03_04_042546) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredient_recipes", force: :cascade do |t|
    t.string "ingredient_id", null: false
    t.string "recipe_id", null: false
    t.string "amount"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amount"], name: "index_ingredient_recipes_on_amount"
    t.index ["ingredient_id", "recipe_id"], name: "index_ingredient_recipes_on_ingredient_id_and_recipe_id", unique: true
    t.index ["ingredient_id"], name: "index_ingredient_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredient_recipes_on_recipe_id"
    t.index ["unit"], name: "index_ingredient_recipes_on_unit"
  end

  create_table "ingredient_tags", force: :cascade do |t|
    t.string "ingredient_id", null: false
    t.string "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id", "tag_id"], name: "index_ingredient_tags_on_ingredient_id_and_tag_id", unique: true
    t.index ["ingredient_id"], name: "index_ingredient_tags_on_ingredient_id"
    t.index ["tag_id"], name: "index_ingredient_tags_on_tag_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.string "recipe_id", null: false
    t.string "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipe_tags_on_recipe_id_and_tag_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.string "cuisine_type"
    t.string "is_vegetarian"
    t.string "calories"
    t.string "prepare_duration"
    t.string "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calories"], name: "index_recipes_on_calories"
    t.index ["category_id"], name: "index_recipes_on_category_id"
    t.index ["cuisine_type"], name: "index_recipes_on_cuisine_type"
    t.index ["is_vegetarian"], name: "index_recipes_on_is_vegetarian"
    t.index ["name"], name: "index_recipes_on_name"
    t.index ["prepare_duration"], name: "index_recipes_on_prepare_duration"
  end

  create_table "steps", force: :cascade do |t|
    t.string "name"
    t.string "step_number"
    t.text "description"
    t.string "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_steps_on_description"
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
    t.index ["step_number"], name: "index_steps_on_step_number"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "tag_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_type"], name: "index_tags_on_tag_type"
  end
end
