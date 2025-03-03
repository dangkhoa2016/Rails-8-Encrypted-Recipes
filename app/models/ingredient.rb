class Ingredient < ApplicationRecord
  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipes, through: :ingredient_recipes
  has_many :ingredient_tags, dependent: :destroy
  has_many :tags, through: :ingredient_tags


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  encrypts :name, deterministic: true
  encrypts :description
end
