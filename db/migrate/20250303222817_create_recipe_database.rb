class CreateRecipeDatabase < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :summary

      t.timestamps
    end

    create_table :recipes do |t|
      t.string :name
      t.string :summary
      t.integer :cuisine_type
      t.boolean :is_vegetarian
      t.integer :calories
      t.integer :prepare_duration
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :ingredient_recipes do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :unit

      t.timestamps
    end

    create_table :steps do |t|
      t.string :name
      t.integer :step_number
      t.text :description
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.integer :tag_type

      t.timestamps
    end

    create_table :recipe_tags do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    create_table :ingredient_tags do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
