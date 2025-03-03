class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :ingredient_tags, dependent: :destroy
end
