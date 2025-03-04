class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags
  has_many :ingredient_tags, dependent: :destroy
  has_many :ingredients, through: :ingredient_tags


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  enum :tag_type, {
    recipe: 0,
    ingredient: 1
  }
end
