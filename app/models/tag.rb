class Tag < ApplicationRecord
  has_many :recipe_tags
  # has_many :recipes, through: :recipe_tags
  has_many :ingredient_tags
  # has_many :ingredients, through: :ingredient_tags

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }

  enum :tag_type, {
    recipe: '0',
    ingredient: '1'
  }


  encrypts :name, deterministic: true

  
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
        RecipeTag.where(tag_id: ids).group(:tag_id).count('id')
      when "ingredient"
        IngredientTag.where(tag_id: ids).group(:tag_id).count('id')
      end

      ids.map { |id| [id, result[id.to_s].to_i] }.to_h
    end

    def count_recipes_by_ids(ids)
      count_records_by_ids(ids, Recipe.name)
    end

    def count_ingredients_by_ids(ids)
      count_records_by_ids(ids, Ingredient.name)
    end
  end
end
