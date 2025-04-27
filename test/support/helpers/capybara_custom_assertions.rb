module CapybaraCustomAssertions
  def assert_alert(expected_text)
    selector = first(:css, 'div[data-alert-target="alert"]')

    within(selector) do
      assert_text expected_text
    end
  end

  def assert_validation_error(expected_text)
    selector = first(:css, 'p.text-red-600')

    within(selector) do
      assert_text expected_text
    end
  end

  def assert_rich_text(rich_text)
    rich_text.to_plain_text.lines.map(&:strip).compact_blank.each do |line|
      assert_text line
    end
  end
end
