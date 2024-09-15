class Clients::Devise::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create]

  layout 'layouts/admin/devise/session'

  def after_sign_up_path_for(_resource)
    root_path
  end
end