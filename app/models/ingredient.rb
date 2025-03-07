class Ingredient < ApplicationRecord
  has_many :ingredient_recipes
  # has_many :recipes, through: :ingredient_recipes
  has_many :ingredient_tags
  # has_many :tags, through: :ingredient_tags

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  encrypts :name, deterministic: true
  encrypts :description


  attr_accessor :virtual_recipes, :virtual_tags
  

  def recipes_list
    virtual_recipes || recipes
  end

  def tags_list
    virtual_tags || tags
  end

  def recipes
    Recipe.where(id: ingredient_recipes.pluck(:recipe_id))
  end

  def tags
    Tag.where(id: ingredient_tags.pluck(:tag_id))
  end


  class << self
    def count_records_by_ids(ids, model)
      model = model.model_name.singular if model.is_a? Class
      result = case model.to_s.downcase
      when "recipe"
        IngredientRecipe.where(ingredient_id: ids).group(:ingredient_id).count('id')
      when "tag"
        IngredientTag.where(ingredient_id: ids).group(:ingredient_id).count('id')
      end

      ids.map { |id| [id, result[id.to_s].to_i] }.to_h
    end

    def count_tags_by_ids(ids)
      count_records_by_ids(ids, Tag.name)
    end

    def count_recipes_by_ids(ids)
      count_records_by_ids(ids, Recipe.name)
    end
  end
end
