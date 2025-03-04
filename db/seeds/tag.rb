recipe_tag_names = [
  "Quick & Easy",
  "Low-Carb",
  "Dairy-Free",
  "Spicy",
  "Family-Friendly",
  "Healthy",
  "Kid-Friendly",
  "Comfort Food",
  "Protein-Packed",
  "Seasonal"
]

ingredient_tag_names = [
  "Chicken",
  "Beef",
  "Fish",
  "Vegetables",
  "Cheese",
  "Rice",
  "Pasta",
  "Herbs & Spices",
  "Fruits",
  "Nuts & Seeds"
]

recipe_tag_names.each do |name|
  begin
    Tag.create!(name: name, tag_type: 'recipe')
  rescue => e
    puts "Failed to create tag: #{name}. Error: #{e.message}"
  end
end

ingredient_tag_names.each do |name|
  begin
    Tag.create!(name: name, tag_type: 'ingredient')
  rescue => e
    puts "Failed to create tag: #{name}. Error: #{e.message}"
  end
end
