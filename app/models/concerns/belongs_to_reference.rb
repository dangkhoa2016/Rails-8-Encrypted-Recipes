module BelongsToReference
  extend ActiveSupport::Concern

  class_methods do
    def add_define_reference_id(association_name)
      define_method("#{association_name}_id") do
        self[association_name.to_s.foreign_key]&.to_i
      end

      define_method("#{association_name}_id=") do |value|
        self[association_name.to_s.foreign_key] = value.present? ? value&.to_i : nil
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
