# frozen_string_literal: true

require 'test_helper'

class Search::FormComponentTest < ViewComponent::TestCase
  BASE_URL = '/admin/courses/search/test'

  def test_renders_form_with_correct_action_and_method
    render_inline(Search::FormComponent.new(base_url: BASE_URL))

    assert_selector "form[action='#{BASE_URL}'][method='get']"
  end

  def test_form_has_correct_data_attributes
    render_inline(Search::FormComponent.new(base_url: BASE_URL))
    form = page.find('form')

    assert_equal 'search', form['data-controller']
    assert_equal 'submit->search#search', form['data-action']
    assert_equal BASE_URL, form['data-search-base-url-value']
  end

  def test_input_has_correct_attributes
    render_inline(Search::FormComponent.new(base_url: BASE_URL))
    input = page.find("input[name='search[term]']")

    assert_equal 'input->search#clearCheck', input['data-action']
    assert_equal 'input', input['data-search-target']
  end

  def test_input_value_empty_when_term_not_present
    render_inline(Search::FormComponent.new(base_url: BASE_URL))
    input = page.find("input[name='search[term]']")

    assert_nil input['value']
  end

  def test_submit_button_has_correct_icon_and_data_target
    render_inline(Search::FormComponent.new(base_url: BASE_URL))

    assert_selector "button[data-search-target='button']"
    assert_selector 'button i.fa-solid.fa-magnifying-glass'
  end

  def test_form_uses_provided_base_url
    render_inline(Search::FormComponent.new(base_url: '/another/search'))

    assert_selector "form[action='/another/search']"
    form = page.find('form')

    assert_equal '/another/search', form['data-search-base-url-value']
  end
end
