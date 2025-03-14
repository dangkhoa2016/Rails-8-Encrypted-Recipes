class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  # has_many :recipes, through: :recipe_tags
  has_many :ingredient_tags, dependent: :destroy
  # has_many :ingredients, through: :ingredient_tags


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  enum :tag_type, {
    recipe: "0",
    ingredient: "1"
  }


  encrypts :name, deterministic: true


  attr_accessor :recipes_count, :ingredients_count, :virtual_recipes, :virtual_ingredients


  def display_ingredients_count
    ingredients_count || ingredients.count
  end

  def display_recipes_count
    recipes_count || recipes.count
  end

  def ingredients_list
    virtual_ingredients || ingredients
  end

  def recipes_list
    virtual_recipes || recipes
  end

  def recipes
    Recipe.where(id: recipe_tags.pluck(:recipe_id))
  end

  def ingredients
    Ingredient.where(id: ingredient_tags.pluck(:ingredient_id))
  end


  class << self
    def count_records_by_ids(ids, model)
      model = model.model_name.singular if model.is_a? Class
      result = case model.to_s.downcase
      when "recipe"
        RecipeTag.where(tag_id: ids).group(:tag_id).count("id")
      when "ingredient"
        IngredientTag.where(tag_id: ids).group(:tag_id).count("id")
      end

      ids.map { |id| [ id, result[id.to_s].to_i ] }.to_h
    end

    def count_recipes_by_ids(ids)
      count_records_by_ids(ids, Recipe.name)
    end

    def count_ingredients_by_ids(ids)
      count_records_by_ids(ids, Ingredient.name)
    end

    def count_recipes
      RecipeTag.group(:tag_id).count("id").transform_keys(&:to_i)
    end

    def count_ingredients
      IngredientTag.group(:tag_id).count("id").transform_keys(&:to_i)
    end

    def recipe_tags_with_count
      Tag.recipe.preload(:recipe_tags).sort_by(&:name)
    end

    def ingredient_tags_with_count
      Tag.ingredient.preload(:ingredient_tags).sort_by(&:name)
    end
  end
end
