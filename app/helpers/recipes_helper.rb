module RecipesHelper
  def cuisine_type_options
    Recipe.cuisine_types.keys.map { |cuisine_type| [ cuisine_type.humanize, cuisine_type ] }
  end
end
