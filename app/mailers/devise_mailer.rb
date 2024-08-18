class DeviseMailer < Devise::Mailer
  helper :application # Adiciona helpers da aplicação, se necessário
  default template_path: 'devise/mailer'
  layout 'mailer' # Especifica o layout que deve ser usado
end
  