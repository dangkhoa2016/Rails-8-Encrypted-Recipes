class EncryptionAttributes < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :ingredient_recipes, column: :ingredient_id
    remove_foreign_key :ingredient_recipes, column: :recipe_id
    change_column :ingredient_recipes, :ingredient_id, :string, null: false
    change_column :ingredient_recipes, :recipe_id, :string, null: false
    change_column :ingredient_recipes, :amount, :string

    remove_foreign_key :ingredient_tags, column: :ingredient_id
    remove_foreign_key :ingredient_tags, column: :tag_id
    change_column :ingredient_tags, :ingredient_id, :string, null: false
    change_column :ingredient_tags, :tag_id, :string, null: false


    remove_foreign_key :recipe_tags, column: :recipe_id
    remove_foreign_key :recipe_tags, column: :tag_id
    change_column :recipe_tags, :recipe_id, :string, null: false
    change_column :recipe_tags, :tag_id, :string, null: false

    change_column :recipes, :is_vegetarian, :string
    change_column :recipes, :calories, :string
    change_column :recipes, :prepare_duration, :string
    change_column :recipes, :cuisine_type, :string
    remove_foreign_key :recipes, column: :category_id
    change_column :recipes, :category_id, :string, null: false

    remove_foreign_key :steps, column: :recipe_id
    change_column :steps, :recipe_id, :string, null: false
    change_column :steps, :step_number, :string

    change_column :tags, :tag_type, :string
  end
end
