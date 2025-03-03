class Ingredient < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :ingredient_tags, dependent: :destroy
end
