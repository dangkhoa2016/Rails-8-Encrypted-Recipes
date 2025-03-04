class IngredientRecipe < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :amount, numericality: { greater_than: 0 }
  validates :unit, presence: true
end
