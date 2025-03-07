class RecipeTag < ApplicationRecord
  include BelongsToReference

  belongs_to :recipe
  belongs_to :tag


  validates :recipe_id, uniqueness: { scope: :tag_id }


  encrypts :recipe_id, deterministic: true
  encrypts :tag_id, deterministic: true
end
