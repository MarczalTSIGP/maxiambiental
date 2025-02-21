# frozen_string_literal: true

class Page::ContentTitleComponent < ViewComponent::Base
  def initialize(title:, description:, bt_label: '', bt_path: '')
    super
    @title = title
    @description = description
    @bt_label = bt_label
    @bt_path = bt_path
  end
end
