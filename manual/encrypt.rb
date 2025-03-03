
category = Category.new
category.name = "Desserts"
category.save


recipe = Recipe.new
recipe.name = "Chocolate Cake"
recipe.summary = "A delicious chocolate cake"
recipe.category = category
recipe.cuisine_type = :american
recipe.is_vegetarian = true
recipe.calories = 300
recipe.prepare_duration = 60
recipe.save

step = Step.new
step.step_number = 1
step.description = "Preheat oven to 350 degrees F (175 degrees C). Grease and flour two 9-inch round pans."
step.recipe = recipe
step.save

ingredient = Ingredient.new
ingredient.name = "sugar"
ingredient.description = "granulated sugar"
ingredient.save

ingredient_recipe = IngredientRecipe.new
ingredient_recipe.recipe = recipe
ingredient_recipe.ingredient = ingredient
ingredient_recipe.amount = 2
ingredient_recipe.unit = "cups"
ingredient_recipe.save


tag = Tag.new
tag.name = "sweet"
tag.save

ingredient.tags << tag



Tag. last. attributes_for_database
=begin

{"id"=>1,
 "name"=>"{\"p\":\"K0QRWw==\",\"h\":{\"iv\":\"fAZjuMry8H4Rms/p\",\"at\":\"fG/dDkwsuuWs9H81aJVo3g==\"}}",
 "tag_type"=>nil,
 "created_at"=>2025-03-04 03:01:16.616602000 UTC +00:00,
 "updated_at"=>2025-03-04 03:01:16.616602000 UTC +00:00}

=end

Tag. last. attributes_for_database. dig('name')
=begin
"{\"p\":\"K0QRWw==\",\"h\":{\"iv\":\"fAZjuMry8H4Rms/p\",\"at\":\"fG/dDkwsuuWs9H81aJVo3g==\"}}"
=end

json = JSON.parse(Tag. last. attributes_for_database. dig('name'))
=begin
{"p"=>"K0QRWw==", "h"=>{"iv"=>"fAZjuMry8H4Rms/p", "at"=>"fG/dDkwsuuWs9H81aJVo3g=="}}
=end


Category. last. attributes_for_database. dig('name')
=begin
"{\"p\":\"XCu6XAgdeZI=\",\"h\":{\"iv\":\"y6Z0g/fS9nv/pqb0\",\"at\":\"KqeS5RIU866g+sJRwr0V5A==\"}}"
=end

