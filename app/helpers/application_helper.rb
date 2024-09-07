module ApplicationHelper
  def tailwind_class_for(flash_type)
    { success: 'bg-green-100 border-green-600 text-green-600',
      error: 'bg-red-100 border-red-600 text-red-600',
      alert: 'bg-orange-100 border-orange-600 text-orange-600',
      notice: 'bg-blue-100 border-blue-600 text-blue-600' }[flash_type.to_sym] || "alert-#{flash_type}"
  end
end
