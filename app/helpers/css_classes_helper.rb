module CssClassesHelper
  # def body_class(options = {})
  #   extra_body_classes_symbol = options[:extra_body_classes_symbol] || :extra_body_classes
  #   qualified_controller_name = controller.controller_path.gsub('/','-')
  #   basic_body_class = "#{qualified_controller_name} #{qualified_controller_name}-#{controller.action_name}"

  #   if content_for?(extra_body_classes_symbol)
  #     [basic_body_class, content_for(extra_body_classes_symbol)].join(' ')
  #   else
  #     basic_body_class
  #   end
  # end

  def extra_body_classes(*args)
    content_for(:extra_body_classes, args.join(' '))
  end

  def main_class(options = {})
    basic_main_class = 'main row'

    if content_for?(:extra_main_classes)
      [basic_main_class, content_for(:extra_main_classes)].join(' ')
    else
      basic_main_class
    end
  end

  def extra_main_classes(*args)
    content_for(:extra_main_classes, args.join(' '))
  end

end
