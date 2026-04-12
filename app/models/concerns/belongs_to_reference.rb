module BelongsToReference
  extend ActiveSupport::Concern

  def self.normalize_reference_id(value)
    return if value.blank?
    return value if value.is_a?(Integer)

    Integer(value, exception: false)
  end

  class_methods do
    def add_define_reference_id(association_name)
      foreign_key = association_name.to_s.foreign_key

      define_method("#{association_name}_id") do
        BelongsToReference.normalize_reference_id(self[foreign_key])
      end

      define_method("#{association_name}_id=") do |value|
        self[foreign_key] = BelongsToReference.normalize_reference_id(value)
      end
    end
  end

  included do
    after_initialize :define_reference_id_getters_and_setters
  end

  def define_reference_id_getters_and_setters
    self.class.reflect_on_all_associations(:belongs_to).each do |association|
      self.class.add_define_reference_id(association.name)
    end
  end
end
