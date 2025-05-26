module ApplicationHelper
  def rc(component_string, **args)
    component_class_name = component_string.split('\\').map(&:camelcase).join('::')
    render "#{component_class_name}Component".constantize.new(**args)
  end

  def full_title(page_title = '', base_title = t('app.name'))
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def current_step
    case action_name
    when 'edit_client', 'process_client_info' then 1
    when 'new', 'process_course_details' then 2
    when 'payment', 'process_payment' then 3
    when 'confirmation' then 4
    end
  end
end
