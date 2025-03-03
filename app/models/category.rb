class Category < ApplicationRecord
  has_many :recipes


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  encrypts :name, deterministic: true
  encrypts :summary
end
