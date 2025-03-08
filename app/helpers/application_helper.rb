module ApplicationHelper
  def nav_list
    [
      {
        model: :recipe,
        icon: 'menu-up'
      },
      {
        model: :ingredient,
        icon: 'box'
      },
      {
        model: nil, # hr
      },
      {
        model: :ingredient_recipe,
        name: 'Ingredient and Recipe',
        icon: 'asterisk'
      },
      {
        model: :step,
        icon: 'bar-chart-steps'
      },
      {
        model: nil, # hr
      },
      {
        model: :category,
        icon: 'bookmark-fill'
      },
      {
        model: :tag,
        icon: 'tags'
      },
    ]
  end

  def is_current_page?(model)
    controller_name == model.to_s.pluralize && action_name != 'index'
  end
end
