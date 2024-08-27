# frozen_string_literal: true

require 'test_helper'

class Alert::AlertComponentTest < ViewComponent::TestCase
  def setup
    @message = "This is a message to test the view!"
  end

  test "renders alert with correct message" do
    render_inline(Alert::AlertComponent.new(
      type: :error,
      message: @message,
    ))

    assert_text @message
  end

  test "close button is present and configured correctly" do
    render_inline(Alert::AlertComponent.new(
      type: :success,
      message: @message,
    ))

    assert_selector "button[data-action='click->alert#close']", count: 1
  end
end
