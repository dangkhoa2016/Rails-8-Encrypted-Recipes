json.extract! recipe, :id, :name, :summary, :cuisine_type, :is_vegetarian, :calories, :prepare_duration, :category_id, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
