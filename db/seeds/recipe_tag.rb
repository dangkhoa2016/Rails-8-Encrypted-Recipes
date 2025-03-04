Recipe.all.each do |recipe|
  count_tags = rand(0..3)
  tags = Tag.recipe.sample(count_tags)
  tags.each do |tag|
    begin
      RecipeTag.create!(recipe: recipe, tag: tag)
    rescue => e
      puts "Failed to create recipe-tag association: #{recipe[:name]}-#{tag[:name]}. Error: #{e.message}"
    end
  end
end
