class Category < ApplicationRecord
  has_many :recipes


  validates :name, presence: true, length: { minimum: 2, maximum: 150 }


  encrypts :name, deterministic: true
  encrypts :summary


  class << self
    def count_records_by_ids(ids, model)
      model = model.model_name.singular if model.is_a? Class
      result = case model.to_s.downcase
      when "recipe"
        Recipe.where(category_id: ids).group(:category_id).count("id")
      end

      ids.map { |id| [ id, result[id.to_s].to_i ] }.to_h
    end

    def count_recipes_by_ids(ids)
      count_records_by_ids(ids, Recipe.name)
    end
  end
end
