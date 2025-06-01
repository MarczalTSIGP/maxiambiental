# frozen_string_literal: true

require 'test_helper'

class MultiStep::FormComponentTest < ViewComponent::TestCase
  def setup
    @steps = [
      { number: 1, label: 'Personal Data' },
      { number: 2, label: 'Course Data' },
      { number: 3, label: 'Payment' },
      { number: 4, label: 'Confirmation' }
    ]
  end

  test 'renders all steps' do
    render_inline(MultiStep::FormComponent.new(current_step: 1, steps: @steps))

    assert_selector('li', count: 4)
  end

  test 'highlights current step' do
    render_inline(MultiStep::FormComponent.new(current_step: 2, steps: @steps))

    assert_selector('li:nth-child(2).text-green-700')
    assert_selector('li:nth-child(2) span.border-green-700')
  end

  test 'shows arrow icon between steps except last' do
    render_inline(MultiStep::FormComponent.new(current_step: 1, steps: @steps))

    assert_selector('.fa-angles-right', count: 3)
    assert_no_selector('li:nth-child(4) .fa-angles-right')
  end

  test 'applies whitespace-nowrap to first three steps' do
    render_inline(MultiStep::FormComponent.new(current_step: 1, steps: @steps))

    assert_selector('li:nth-child(1) span.whitespace-nowrap')
    assert_selector('li:nth-child(2) span.whitespace-nowrap')
    assert_selector('li:nth-child(3) span.whitespace-nowrap')
  end

  test 'renders correct step numbers and labels' do
    render_inline(MultiStep::FormComponent.new(current_step: 3, steps: @steps))

    @steps.each_with_index do |step, index|
      assert_selector("li:nth-child(#{index + 1})", text: step[:number].to_s)
      assert_selector("li:nth-child(#{index + 1})", text: step[:label])
    end
  end

  test 'responsive classes are present' do
    render_inline(MultiStep::FormComponent.new(current_step: 1, steps: @steps))

    assert_selector('ol.sm\\:bg-white')
    assert_selector('ol.sm\\:text-base')
    assert_selector('span.hidden.lg\\:inline')
  end
end
