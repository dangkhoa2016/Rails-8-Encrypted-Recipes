
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
tag.tag_type = "recipe"
tag.save

ingredient.tags << tag
