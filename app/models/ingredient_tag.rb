class IngredientTag < ApplicationRecord
  include BelongsToReference

  belongs_to :ingredient
  belongs_to :tag


  validates :ingredient_id, uniqueness: { scope: :tag_id }


  encrypts :ingredient_id, deterministic: true
  encrypts :tag_id, deterministic: true
end
