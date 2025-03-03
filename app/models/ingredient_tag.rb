class IngredientTag < ApplicationRecord
  include BelongsToReference

  belongs_to :ingredient
  belongs_to :tag


  encrypts :ingredient_id, deterministic: true
  encrypts :tag_id, deterministic: true
end
