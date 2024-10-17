# frozen_string_literal: true

class Flash::MessageComponent < ViewComponent::Base
  def messages
    helpers.flash.delete(:timedout)
  end

  def alert_css_classes(flash_type)
    "relative flex w-full p-4 text-sm rounded border-l-4 mb-4 #{class_type(flash_type)}"
  end

  private

  def class_type(flash_type)
    { success: 'bg-green-100 border-green-600 text-green-600',
      error: 'bg-red-100 border-red-600 text-red-600',
      alert: 'bg-orange-100 border-orange-600 text-orange-600',
      notice: 'bg-blue-100 border-blue-600 text-blue-600' }[flash_type.to_sym] || "alert-#{flash_type}"
  end
end
