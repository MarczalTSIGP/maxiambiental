class ToggleSwitchInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] = 'peer sr-only'
    options[:label] ||= object.class.human_attribute_name(attribute_name)

    build_switch_content(merged_input_options)
  end

  def label
    ''
  end

  private

  def build_switch_content(merged_input_options)
    template.content_tag(:label,
                         class: 'inline-flex items-center cursor-pointer text-green-700 text-sm font-bold mb-2') do
      template.content_tag(:span, options[:label], class: 'inline-flex items-center cursor-pointer mr-3') +
        @builder.check_box(attribute_name, merged_input_options) +
        template.content_tag(:div, '', id: :toggle, class: switch_classes)
    end
  end

  def switch_classes
    'relative w-11 h-6 bg-gray-200 rounded-full peer peer-checked:after:translate-x-full ' \
      'rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white ' \
      "after:content-[''] after:absolute after:top-0.5 after:start-[2px] after:bg-white " \
      'after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 ' \
      'after:transition-all peer-checked:bg-green-700'
  end
end
