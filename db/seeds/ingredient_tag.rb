Ingredient.all.each do |ingredient|
  count_tags = rand(0..3)
  tags = Tag.ingredient.sample(count_tags)
  tags.each do |tag|
    begin
      IngredientTag.create!(ingredient: ingredient, tag: tag)
    rescue => e
      puts "Failed to create ingredient-tag association: #{ingredient[:name]}-#{tag[:name]}. Error: #{e.message}"
    end
  end
end
