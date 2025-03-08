class Step < ApplicationRecord
  include BelongsToReference

  belongs_to :recipe

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates :description, presence: true, length: { minimum: 2 }


  encrypts :description
  encrypts :step_number, deterministic: true
  encrypts :recipe_id, deterministic: true


  after_destroy :reorder_steps


  def step_number
    super&.to_i
  end

  def step_number=(value)
    super value&.to_i
  end

  private

  def reorder_steps
    recipe.steps.sort_by(&:step_number).each_with_index do |step, index|
      next if step.destroyed?
      step.update_column(:step_number, index + 1)
    end
  end
end
