# frozen_string_literal: true

#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  # config.item_wrapper_tag = :span

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required, explicit_label| "#{required} #{label}" }
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overridden
  # with `html: { :class }`. Defaulting to none.
  # config.default_form_class = nil

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << "CustomInputs"

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  # config.input_class = nil

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'

  # Defines validation classes to the input_field. By default it's nil.
  # config.input_field_valid_class = 'is-valid'
  # config.input_field_error_class = 'is-invalid'

  config.wrappers :tailwind, tag: 'div', class: 'mb-4 space-y-4 md:space-y-6', error_class: 'text-red-500' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :input_wrapper, tag: 'div' do |ba|
      ba.use :label, class: 'block text-green-700 text-sm font-bold mb-2'
      ba.use :input,
             class: 'shadow border border-gray-300 rounded-md w-full p-2.5 
                            text-gray-700 leading-tight focus:outline-hidden focus:border-green-700 focus:ring-green-700 
                            disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-gray-200 disabled:border-gray-400 disabled:text-gray-600'

      ba.use :error, wrap_with: { tag: :p, class: 'mt-2 text-sm text-red-600' }
      ba.use :hint, wrap_with: { tag: :p, class: 'mt-2 text-sm text-gray-500' }
    end
  end

  config.wrappers :checkbox, tag: 'div', class: 'flex flex-col items-start', error_class: 'text-red-500' do |b|
    b.use :html5
    b.use :placeholder

    b.wrapper :checkbox_container, tag: 'div', class: 'flex items-center' do |ba|
      ba.use :input,
             class: 'text-green-600 bg-gray-100 border-gray-300 rounded focus:ring-green-500',
             error_class: 'text-red-500'
      
      ba.use :label, class: 'ml-2 text-md text-gray-500'
    end

    b.use :error, wrap_with: { tag: :p, class: 'mt-1 text-sm text-red-600' }
    b.use :hint, wrap_with: { tag: :p, class: 'mt-1 text-sm text-gray-500' }
  end

  config.wrappers :horizontal_radio, tag: 'div', class: 'mb-3', error_class: 'border-red-500' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div' do |ba|
      ba.use :label, class: 'block text-green-700 text-sm font-bold mb-2'
      ba.wrapper tag: 'div', class: 'flex items-center gap-4 text-sm text-green-700' do |bb|
        bb.use :input, 
          class: 'mr-2 text-green-700 border-gray-300 focus:ring-green-600 align-baseline',
          error_class: 'border-red-500'
        bb.use :error, wrap_with: { tag: 'p', class: 'mt-2 text-sm text-red-600' }
      end
    end
  end


  config.button_class = 'text-white py-2 px-4 rounded-md bg-green-700 hover:bg-green-800 cursor-pointer'

  config.wrappers :form_button, tag: :button, class: "btn" do |b|
    b.use :html_input
    b.wrapper tag: :div, class: "flex justify-center" do
      b.use :input, class: "w-full text-white py-2 px-4 rounded-md bg-green-700 hover:bg-green-800 cursor-pointer"
    end
  end

  config.wrappers :search, tag: 'div', class: 'w-full' do |b|
    b.use :html5
    b.use :placeholder

    b.wrapper :input_wrapper, tag: 'div' do |ba|
      ba.use :input,
             class: 'shadow border border-gray-300 rounded-md w-full p-2.5 
                            text-gray-700 leading-tight focus:outline-none focus:border-green-700 focus:ring-green-700 
                            disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-gray-200 disabled:border-gray-400 disabled:text-gray-600'
    end
  end

  config.wrappers :datetime, tag: 'div', class: 'mb-4 space-y-4 md:space-y-6', error_class: 'text-red-500' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :input_wrapper, tag: 'div' do |ba|
      ba.use :label, class: 'block text-green-700 text-sm font-bold mb-2'
      ba.use :input,
            class: 'shadow border border-gray-300 rounded-md w-fit p-2 
                    text-gray-700 leading-tight focus:outline-none focus:border-green-700 focus:ring-green-700 
                    disabled:opacity-50 disabled:cursor-not-allowed disabled:bg-gray-200 disabled:border-gray-400 disabled:text-gray-600
                    datetime-picker'
      
      ba.use :error, wrap_with: { tag: :p, class: 'mt-2 text-sm text-red-600' }
      ba.use :hint, wrap_with: { tag: :p, class: 'mt-2 text-sm text-gray-500' }
    end
  end

  config.default_wrapper = :tailwind
end
