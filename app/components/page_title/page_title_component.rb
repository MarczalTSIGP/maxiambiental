# frozen_string_literal: true

class PageTitle::PageTitleComponent < ViewComponent::Base
  def initialize(title:, description:, with_buttons: false)
    @title = title
    @description = description
    @with_buttons = with_buttons
  end
end
