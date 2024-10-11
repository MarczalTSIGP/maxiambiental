# frozen_string_literal: true

class Page::ContentTitleComponent < ViewComponent::Base
  def initialize(title:, description:, with_buttons: false)
    super
    @title = title
    @description = description
    @with_buttons = with_buttons
  end
end
