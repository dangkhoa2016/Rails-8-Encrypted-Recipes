class RecipeTag < ApplicationRecord
  include BelongsToReference

  belongs_to :recipe
  belongs_to :tag


  encrypts :recipe_id, deterministic: true
  encrypts :tag_id, deterministic: true
end
