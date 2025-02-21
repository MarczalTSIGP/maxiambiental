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
end
