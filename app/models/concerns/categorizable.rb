module Concerns
  module Categorizable
    extend ActiveSupport::Concern

    module ClassMethods

      def has_one_category(name)
        tagging_name = :"#{name}_tagging"
        tag_name = name.to_sym
        has_one tagging_name, as: :taggable, dependent: :destroy, class_name: "Tagging::#{name.to_s.classify}"
        has_one tag_name, through: tagging_name, source: :tag, class_name: "Tag"

        # def discipline_name
        delegate :name, to: tag_name, allow_nil: true, prefix: true

        define_method("#{tag_name}_name=") do |value|
          return if value.blank?

          self.send("#{tag_name}=", Tag.find_by(name: self.class.normalize_category_name(value)))
        end
      end

      def has_many_categories(name)
        tagging_name = :"#{name}_tagging"
        tag_name = name.to_sym
        has_many tagging_name, as: :taggable, dependent: :destroy, class_name: "Tagging::#{name.to_s.classify}"
        has_many tag_name, through: tagging_name, source: :tag, class_name: "Tag"

        # def discipline_names
        define_method("#{tag_name.to_s.singularize}_names") do
          self.send(tag_name).pluck('name')
        end

        define_method("#{tag_name.to_s.singularize}_names=") do |values|
          self.send("#{tag_name}=", Tag.where(name: self.class.normalize_category_names(values)))
        end
      end

      def normalize_category_names(names)
        names.reject(&:blank?).map { |n| normalize_category_name(n) }
      end

      def normalize_category_name(name)
        Tag.normalize_category_name(name)
      end

    end
  end
end
