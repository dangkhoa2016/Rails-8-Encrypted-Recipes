class IngredientRecipe < ApplicationRecord
  include BelongsToReference

  belongs_to :ingredient
  belongs_to :recipe

  validates :amount, numericality: { greater_than: 0 }
  validates :unit, presence: true


  encrypts :ingredient_id, deterministic: true
  encrypts :recipe_id, deterministic: true
  encrypts :amount
  encrypts :unit


  def amount
    super&.to_f
  end

  def amount=(value)
    super(value&.to_s)
  end
end
