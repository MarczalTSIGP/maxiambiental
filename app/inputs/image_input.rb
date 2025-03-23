class ImageInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    @merged_input_options = build_merged_input_options(wrapper_options)

    template.content_tag(:div, wrapper_attributes) do
      preview_image_tag + input_components
    end
  end

  private

  def build_merged_input_options(wrapper_options)
    merged = merge_wrapper_options(input_html_options, wrapper_options)
    merged[:class] = [merged[:class], 'peer sr-only'].compact.join(' ')
    merged[:'data-action'] = 'change->input-image#loadFile'
    merged
  end

  def wrapper_attributes
    {
      data: { controller: 'input-image' },
      class: 'flex items-center gap-6'
    }
  end

  def input_components
    template.content_tag(:div, class: 'flex items-center sm:flex-col gap-4') do
      input_label
    end
  end

  def input_label
    template.content_tag(:label, class: 'cursor-pointer block') do
      select_button + @builder.file_field(attribute_name, @merged_input_options)
    end
  end

  def select_button
    template.content_tag(:span, 'Escolher imagem', class: 'block btn-outline',
                                                   data: { 'input-image-target' => 'labelText' })
  end

  def preview_image_tag
    template.content_tag(:div, class: 'shrink-0') do
      template.image_tag(
        preview_image_url,
        id: 'preview_img',
        data: { 'input-image-target' => 'preview' },
        class: 'h-16 w-16 object-cover aspect-square rounded-md border-solid border-black',
        alt: object.try(:name).presence
      )
    end
  end

  def preview_image_url
    if object.send(attribute_name).attached?
      Rails.application.routes.url_helpers.rails_blob_url(
        object.send(attribute_name).attachment,
        only_path: true
      )
    else
      default_image_url
    end
  end

  def default_image_url
    ActionController::Base.helpers.asset_path('card-default.png')
  end
end
