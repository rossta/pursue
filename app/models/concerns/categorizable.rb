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
          self.send("#{tag_name}=", Tag.find_by(name: value))
        end
      end

      def has_many_categories(name)
        tagging_name = :"#{name}_tagging"
        tag_name = name.to_sym
        has_many tagging_name, as: :taggable, dependent: :destroy, class_name: "Tagging::#{name.to_s.classify}"
        has_many tag_name, through: tagging_name, source: :tag, class_name: "Tag"

        # def discipline_name
        delegate :name, to: tag_name, allow_nil: true, prefix: true

        define_method("#{tag_name}_names=") do |values|
          self.send("#{tag_name}=", Tag.find_all_by(name: values))
        end
      end

    end
  end
end
