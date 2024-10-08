module ApplicationHelper
  def rc(component_string)
    component_class_name = component_string.to_s.split('_').map(&:capitalize).join('::')
    render "#{component_class_name}Component".constantize.new
  end
end
