class Step < ApplicationRecord
  include BelongsToReference

  belongs_to :recipe

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates :description, presence: true, length: { minimum: 2 }


  encrypts :description
  encrypts :step_number, deterministic: true
  encrypts :recipe_id, deterministic: true


  def step_number
    super&.to_i
  end

  def step_number=(value)
    super value&.to_i
  end
end
