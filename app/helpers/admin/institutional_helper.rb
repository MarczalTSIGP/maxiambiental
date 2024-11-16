module Admin::InstitutionalHelper
  def render_rich_text_image(content, index, classes = "")
    if content.body.attachments[index].present?
      image_tag content.body.attachments[index],
                class: classes,
                alt: "Maxiambiental"
    end
  end
end
