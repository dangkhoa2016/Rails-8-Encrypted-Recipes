class Recipe < ApplicationRecord
  include BelongsToReference

  belongs_to :category

  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :steps, dependent: :destroy
  # has_many :ingredients, through: :ingredient_recipes
  # has_many :tags, through: :recipe_tags


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  enum :cuisine_type, {
    american: "0",
    italian: "1",
    mexican: "2",
    chinese: "3",
    japanese: "4",
    indian: "5",
    french: "6",
    mediterranean: "7",
    middle_eastern: "8",
    thai: "9",
    vietnamese: "10",
    korean: "11",
    other: "12"
  }


  encrypts :is_vegetarian
  encrypts :calories
  encrypts :prepare_duration, deterministic: true
  encrypts :cuisine_type, deterministic: true
  encrypts :category_id, deterministic: true
  encrypts :name, deterministic: true
  encrypts :summary


  attr_accessor :steps_count, :ingredients_count, :tags_count, :virtual_ingredient_recipes


  def display_ingredient_recipes
    virtual_ingredient_recipes || ingredient_recipes
  end

  def display_steps_count
    steps_count || steps.count
  end

  def display_ingredients_count
    ingredients_count || ingredients.count
  end

  def display_tags_count
    tags_count || tags.count
  end

  def is_vegetarian
    value = super rescue nil
    value == "t" || value == "true"
  end

  def is_vegetarian=(value)
    super(value.to_s.downcase == "true")
  end

  def calories
    super&.to_i
  end

  def calories=(value)
    super value&.to_i
  end

  def prepare_duration
    super&.to_i
  end

  def prepare_duration=(value)
    super value&.to_i
  end

  def ingredients
    Ingredient.where(id: ingredient_recipes.pluck(:ingredient_id))
  end

  def tags
    Tag.where(id: recipe_tags.pluck(:tag_id))
  end


  class << self
    def count_records_by_ids(ids, model)
      model = model.model_name.singular if model.is_a? Class
      result = case model.to_s.downcase
      when "ingredient"
        IngredientRecipe.where(recipe_id: ids).group(:recipe_id).count("id")
      when "tag"
        RecipeTag.where(recipe_id: ids).group(:recipe_id).count("id")
      when "step"
        Step.where(recipe_id: ids).group(:recipe_id).count("id")
      end

      ids.map { |id| [ id, result[id.to_s].to_i ] }.to_h
    end

    def count_tags_by_ids(ids)
      count_records_by_ids(ids, Tag.name)
    end

    def count_ingredients_by_ids(ids)
      count_records_by_ids(ids, Ingredient.name)
    end

    def count_steps_by_ids(ids)
      count_records_by_ids(ids, Step.name)
    end
  end
end
