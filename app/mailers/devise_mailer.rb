class DeviseMailer < Devise::Mailer
  helper :application
  default template_path: 'devise/mailer'
  layout 'mailer'
end
