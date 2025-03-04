class Step < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates :description, presence: true, length: { minimum: 2 }
end
