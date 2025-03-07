module TagUpdater
  extend ActiveSupport::Concern

  def update_tags(model, model_tags)
    old_tags = model.tags.pluck(:id)
    new_tags = params[:tag_ids]&.map(&:to_i) || []
    model_tags = model_tags.where("#{model.class.name.downcase}_id": model.id)

    if new_tags.size >= old_tags.size
      new_tags.each_with_index do |tag_id, index|
        if index < old_tags.size
          model_tags[index].update(tag_id: tag_id)
        else
          model_tags.create("#{model.class.name.downcase}_id": model.id, tag_id: tag_id)
        end
      end
    else
      remove_tag_count = old_tags.size - new_tags.size
      model_tags.last(remove_tag_count).each(&:destroy)
      model_tags.each_with_index do |model_tag, index|
        model_tag.update(tag_id: new_tags[index])
      end
    end
  end
end
