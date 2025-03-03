class Recipe < ApplicationRecord
  belongs_to :category

  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :steps, dependent: :destroy
end
