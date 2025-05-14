# frozen_string_literal: true

require 'test_helper'

class Dashboard::StatsComponentTest < ViewComponent::TestCase
  def setup
    @positive_stats = { count: 150, growth: 10 }
    @negative_stats = { count: 80, growth: -5 }
    @zero_stats = { count: 100, growth: 0 }
  end

  def test_positive_growth_styles
    render_inline(Dashboard::StatsComponent.new(stats: @positive_stats))

    assert_selector('.bg-green-200')
    assert_selector('.text-green-700')
  end

  def test_positive_growth_icon
    render_inline(Dashboard::StatsComponent.new(stats: @positive_stats))

    assert_selector('.fa-arrow-up')
  end

  def test_positive_growth_content
    render_inline(Dashboard::StatsComponent.new(stats: @positive_stats, text: 'New Clients'))

    assert_text('150')
    assert_text('New Clients')
    assert_text('+10%')
  end

  def test_negative_growth_styles
    render_inline(Dashboard::StatsComponent.new(stats: @negative_stats))

    assert_selector('.bg-red-200')
    assert_selector('.text-red-700')
  end

  def test_negative_growth_icon
    render_inline(Dashboard::StatsComponent.new(stats: @negative_stats))

    assert_selector('.fa-arrow-down')
  end

  def test_negative_growth_content
    render_inline(Dashboard::StatsComponent.new(stats: @negative_stats, text: 'New Sales'))

    assert_text('80')
    assert_text('New Sales')
    assert_text('-5%')
  end

  def test_renders_component_with_zero_growth
    render_inline(Dashboard::StatsComponent.new(stats: @zero_stats, text: 'Pedidos'))

    assert_selector('.bg-red-200')
    assert_selector('.fa-arrow-down')
    assert_text('0%')
  end

  def test_renders_without_text
    render_inline(Dashboard::StatsComponent.new(stats: @positive_stats))

    assert_text('150')
    assert_no_text('undefined')
  end

  def test_formatted_growth
    component = Dashboard::StatsComponent.new(stats: @positive_stats)

    assert_equal('+10%', component.formatted_growth)

    component = Dashboard::StatsComponent.new(stats: @negative_stats)

    assert_equal('-5%', component.formatted_growth)
  end

  def test_style_color
    component = Dashboard::StatsComponent.new(stats: @positive_stats)

    assert_equal('green', component.style_color)

    component = Dashboard::StatsComponent.new(stats: @negative_stats)

    assert_equal('red', component.style_color)
  end

  def test_style_icon
    component = Dashboard::StatsComponent.new(stats: @positive_stats)

    assert_equal('arrow-up', component.style_icon)

    component = Dashboard::StatsComponent.new(stats: @negative_stats)

    assert_equal('arrow-down', component.style_icon)
  end
end
