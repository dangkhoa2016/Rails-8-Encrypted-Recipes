class IngredientRecipe < ApplicationRecord
  include BelongsToReference

  belongs_to :ingredient
  belongs_to :recipe

  validates :amount, numericality: { greater_than: 0 }
  validates :unit, presence: true
  validates :ingredient_id, uniqueness: { scope: :recipe_id }


  encrypts :ingredient_id, deterministic: true
  encrypts :recipe_id, deterministic: true
  encrypts :amount
  encrypts :unit


  attr_accessor :virtual_ingredient, :virtual_recipe


  def display_ingredient
    virtual_ingredient || ingredient
  end

  def display_recipe
    virtual_recipe || recipe
  end

  def amount
    super&.to_f
  end

  def amount=(value)
    super(value&.to_s)
  end

  def display_amount
    (amount&.to_i == amount ? amount.to_i : amount).to_s
  end
end
