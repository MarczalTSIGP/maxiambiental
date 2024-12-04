# frozen_string_literal: true

class Page::ContentTitleComponent < ViewComponent::Base
  def initialize(title:, description:, with_buttons: false, bt_label: '', bt_path: '')
    super
    @title = title
    @description = description
    @with_buttons = with_buttons
    @bt_label = bt_label
    @bt_path = bt_path
  end
end
