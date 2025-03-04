all_ingredients = Ingredient.all
units = ["grams", "kilograms", "milliliters", "liters", "ounces", "pounds", "teaspoons", "tablespoons", "cups", "gallons", 
         "inches", "feet", "yards", "centimeters", "meters", "kilometers", "seconds", "minutes", "hours", "days"]

Recipe.all.each do |recipe|
  count_ingredients = rand(3..6)
  ingredients = all_ingredients.sample(count_ingredients)
  ingredients.each do |ingredient|
    begin
      amount = rand(0.01..10).round(2)
      amount = amount.to_i if rand(10) > 6 && amount > 1
      IngredientRecipe.create!(recipe: recipe, ingredient: ingredient,
        amount: amount, unit: units.sample)
    rescue => e
      puts "Failed to create ingredient-recipe association: #{ingredient[:name]}-#{recipe[:name]}. Error: #{e.message}"
    end
  end
end
