# frozen_string_literal: true

class Dashboard::StatsComponent < ViewComponent::Base
  def initialize(stats:, text: '', id: '')
    super
    @stats = stats
    @text = text
    @id = id
  end

  def count
    @stats[:count]
  end

  def growth
    @stats[:growth]
  end

  def style_color
    growth.positive? ? 'green' : 'red'
  end

  def style_icon
    growth.positive? ? 'arrow-up' : 'arrow-down'
  end

  def formatted_growth
    growth.positive? ? "+#{growth}%" : "#{growth}%"
  end
end
