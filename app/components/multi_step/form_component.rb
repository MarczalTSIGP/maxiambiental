# frozen_string_literal: true

class MultiStep::FormComponent < ViewComponent::Base
  attr_reader :current_step, :steps

  def initialize(current_step:, steps:)
    super
    @current_step = current_step
    @steps = steps
  end
end
