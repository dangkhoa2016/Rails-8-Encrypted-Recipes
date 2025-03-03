json.extract! ingredient_recipe, :id, :ingredient_id, :recipe_id, :amount, :unit, :created_at, :updated_at
json.url ingredient_recipe_url(ingredient_recipe, format: :json)
