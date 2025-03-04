# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Start seeding the database at #{Time.now}..."

puts "Seeding the database with categories..."
load 'db/seeds/category.rb'
puts "Seeded the database with #{Category.count} categories!"

puts "Seeding the database with recipes..."
load 'db/seeds/recipe.rb'
puts "Seeded the database with #{Recipe.count} recipes!"

puts "Seeding the database with tags..."
load 'db/seeds/tag.rb'
puts "Seeded the database with #{Tag.count} tags!"

puts "Seeding the database with ingredients..."
load 'db/seeds/ingredient.rb'
puts "Seeded the database with #{Ingredient.count} ingredients!"

puts "Seeding the database with ingredient-recipe associations..."
load 'db/seeds/ingredient_recipe.rb'
puts "Seeded the database with #{IngredientRecipe.count} ingredient-recipe associations!"

puts "Seeding the database with recipe-tag associations..."
load 'db/seeds/recipe_tag.rb'
puts "Seeded the database with #{RecipeTag.count} recipe-tag associations!"

puts "Seeding the database with ingredient-tag associations..."
load 'db/seeds/ingredient_tag.rb'
puts "Seeded the database with #{IngredientTag.count} ingredient-tag associations!"

puts "Seeding the database with steps..."
load 'db/seeds/step.rb'
puts "Seeded the database with #{Step.count} steps!"

puts "Database has been seeded successfully at #{Time.now}!"
