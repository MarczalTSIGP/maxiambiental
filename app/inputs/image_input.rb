# app/inputs/image_input.rb
class ImageInput < SimpleForm::Inputs::Base
  DEFAULT_IMAGE_PATH = 'card-default.png'.freeze
  CONTROLLER_NAME = 'input-image'.freeze
  ACCEPTED_TYPES = 'image/png, image/jpeg'.freeze

  def input(wrapper_options = nil)
    template.content_tag(:div, wrapper_attributes) do
      preview_container + default_upload_area(merged_options(wrapper_options))
    end
  end

  private

  module HtmlBuilders
    def icon_with_text(icon_class, text)
      template.content_tag(:div, class: 'text-center px-4') do
        template.icon('fa-solid', icon_class, class: 'fa-3x mb-6 text-gray-400') +
          template.content_tag(:p, text, class: 'mb-3 text-sm text-gray-500 font-semibold')
      end
    end

    def wrapped_container(attributes, &)
      template.content_tag(:div, attributes, &)
    end
  end

  include HtmlBuilders

  def merged_options(wrapper_options)
    merge_wrapper_options(input_html_options, wrapper_options).deep_merge(
      class: 'hidden',
      accept: ACCEPTED_TYPES,
      data: {
        "#{CONTROLLER_NAME}-target": 'input',
        action: 'change->input-image#loadFile'
      }
    )
  end

  def wrapper_attributes
    {
      class: 'relative w-full h-64 border-dashed border-2 border-gray-300 rounded-lg bg-white',
      data: { controller: CONTROLLER_NAME }
    }
  end

  def preview_container
    wrapped_container(preview_attributes) do
      wrapped_container(center_container_attributes) do
        wrapped_container(aspect_ratio_container_attributes) do
          preview_image + remove_button
        end
      end
    end
  end

  def preview_image
    template.image_tag(
      preview_image_url,
      data: { "#{CONTROLLER_NAME}-target": 'previewImage' },
      class: 'w-full h-full object-cover rounded-xl shadow-lg'
    )
  end

  def preview_attributes
    {
      class: class_names('w-full h-full', hidden: !image_attached?),
      data: {
        "#{CONTROLLER_NAME}-target": 'previewContainer',
        'existing-image': image_attached?
      }
    }
  end

  def default_upload_area(options)
    template.content_tag(:label, label_attributes) do
      upload_content + @builder.file_field(attribute_name, options)
    end
  end

  def label_attributes
    {
      class: class_names(
        'absolute inset-0 flex flex-col items-center justify-center rounded-lg cursor-pointer hover:bg-gray-100',
        'hidden' => image_attached?
      ),
      data: { "#{CONTROLLER_NAME}-target": 'defaultContent' }
    }
  end

  def upload_content
    icon_with_text('cloud-arrow-up', 'Clique para enviar')
  end

  def remove_button
    template.button_tag(
      'X',
      type: 'button',
      class: 'absolute top-2 right-2 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center',
      data: { action: "#{CONTROLLER_NAME}#removeImage" }
    )
  end

  def preview_image_url
    image_attached? ? attached_image_url : DEFAULT_IMAGE_PATH
  end

  def attached_image_url
    Rails.application.routes.url_helpers.rails_blob_url(
      object.send(attribute_name).blob,
      only_path: true
    )
  end

  def image_attached?
    @image_attached ||= object.send(attribute_name).attached?
  end

  # Helper methods para atributos de containers
  def center_container_attributes
    { class: 'w-full h-full p-6 flex items-center justify-center' }
  end

  def aspect_ratio_container_attributes
    { class: 'relative h-full aspect-[3/4]' }
  end
end
