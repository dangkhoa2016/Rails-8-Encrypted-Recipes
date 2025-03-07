class EncryptionAttributes < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :ingredient_recipes, column: :ingredient_id
    remove_foreign_key :ingredient_recipes, column: :recipe_id
    change_column :ingredient_recipes, :ingredient_id, :string, null: false
    change_column :ingredient_recipes, :recipe_id, :string, null: false
    change_column :ingredient_recipes, :amount, :string
    add_index :ingredient_recipes, [ :ingredient_id, :recipe_id ], unique: true
    # add_index :ingredient_recipes, :recipe_id
    # add_index :ingredient_recipes, :ingredient_id
    add_index :ingredient_recipes, :amount
    add_index :ingredient_recipes, :unit

    remove_foreign_key :ingredient_tags, column: :ingredient_id
    remove_foreign_key :ingredient_tags, column: :tag_id
    change_column :ingredient_tags, :ingredient_id, :string, null: false
    change_column :ingredient_tags, :tag_id, :string, null: false
    add_index :ingredient_tags, [ :ingredient_id, :tag_id ], unique: true
    # add_index :ingredient_tags, :tag_id
    # add_index :ingredient_tags, :ingredient_id

    remove_foreign_key :recipe_tags, column: :recipe_id
    remove_foreign_key :recipe_tags, column: :tag_id
    change_column :recipe_tags, :recipe_id, :string, null: false
    change_column :recipe_tags, :tag_id, :string, null: false
    add_index :recipe_tags, [ :recipe_id, :tag_id ], unique: true
    # add_index :recipe_tags, :tag_id
    # add_index :recipe_tags, :recipe_id

    change_column :recipes, :is_vegetarian, :string
    change_column :recipes, :calories, :string
    change_column :recipes, :prepare_duration, :string
    change_column :recipes, :cuisine_type, :string
    remove_foreign_key :recipes, column: :category_id
    change_column :recipes, :category_id, :string, null: false
    # add_index :recipes, :category_id
    add_index :recipes, :name
    add_index :recipes, :is_vegetarian
    add_index :recipes, :calories
    add_index :recipes, :prepare_duration
    add_index :recipes, :cuisine_type

    remove_foreign_key :steps, column: :recipe_id
    change_column :steps, :recipe_id, :string, null: false
    change_column :steps, :step_number, :string
    # add_index :steps, :recipe_id
    add_index :steps, :step_number
    add_index :steps, :description

    change_column :tags, :tag_type, :string
    add_index :tags, :tag_type
  end
end
