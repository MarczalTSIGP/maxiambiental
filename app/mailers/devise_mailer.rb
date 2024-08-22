class DeviseMailer < Devise::Mailer
  helper :application
  default template_path: 'devise/mailer'
  layout 'devise/mailer'
end
  