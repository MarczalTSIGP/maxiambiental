class DeviseMailer < Devise::Mailer
  helper :application
  default template_path: 'admin/devise/mailer'
  layout 'admin/devise/mailer'
end
