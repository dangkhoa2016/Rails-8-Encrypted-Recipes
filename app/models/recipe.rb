class Recipe < ApplicationRecord
  include BelongsToReference

  belongs_to :category

  has_many :ingredient_recipes, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :ingredients, through: :ingredient_recipes
  has_many :tags, through: :recipe_tags


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  enum :cuisine_type, {
    american: "0",
    italian: "1",
    mexican: "2",
    chinese: "3",
    japanese: "4",
    indian: "5",
    french: "6",
    mediterranean: "7",
    middle_eastern: "8",
    thai: "9",
    vietnamese: "10",
    korean: "11",
    other: "12"
  }


  encrypts :is_vegetarian
  encrypts :calories
  encrypts :prepare_duration, deterministic: true
  encrypts :cuisine_type, deterministic: true
  encrypts :category_id, deterministic: true
  encrypts :name, deterministic: true
  encrypts :summary


  def is_vegetarian
    value = super rescue nil
    value == "t" || value == "true"
  end

  def is_vegetarian=(value)
    super(value.to_s.downcase == "true")
  end

  def calories
    super&.to_i
  end

  def calories=(value)
    super value&.to_i
  end

  def prepare_duration
    super&.to_i
  end

  def prepare_duration=(value)
    super value&.to_i
  end
end
