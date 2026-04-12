class DashboardService
  def top_widgets
    {
      categories: Category.count,
      recipes: Recipe.count,
      ingredients: Ingredient.count,
      tags: Tag.count
    }
  end

  def latest_recipes
    Recipe.preload(:steps).order(created_at: :desc).limit(5)
  end

  def ingredient_tags
    Tag.ingredient_tags_with_count
  end

  def recipe_tags
    Tag.recipe_tags_with_count
  end

  def top_cuisines
    Recipe.where.not(cuisine_type: nil)
          .group(:cuisine_type)
          .count
          .sort_by { |_k, v| -v }
          .map { |k, v| { name: k.titleize, count: v, slug: k } }
  end
end
