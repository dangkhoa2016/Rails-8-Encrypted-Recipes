class Ingredient < ApplicationRecord
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes
  has_many :ingredient_tags
  has_many :tags, through: :ingredient_tags

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
end
