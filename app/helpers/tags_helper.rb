module TagsHelper
  def tag_type_options
    Tag.tag_types.keys.map { |tag_type| [ tag_type.humanize, tag_type ] }
  end
end
