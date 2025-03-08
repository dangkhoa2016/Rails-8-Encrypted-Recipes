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

  def confirm_delete_attributes(record)
    confirm_message = "Are you sure you want to delete this #{record.class.model_name.human.downcase} with Id: #{record.id}?"
    {
      turbo_method: 'delete',
      turbo_confirm: confirm_message,
      confirm: confirm_message,
      turbo_frame: 'modal_frame', closable: false, remote: true,
      confirm_yes: 'Yes', modal_title: 'Please Confirm',
    }
  end
end
