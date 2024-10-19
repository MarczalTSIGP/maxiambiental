# frozen_string_literal: true

class Clients::Devise::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create]

  layout 'layouts/clients/devise/sessions'

  def after_sign_up_path_for(_resource)
    clients_root_path
  end
end
