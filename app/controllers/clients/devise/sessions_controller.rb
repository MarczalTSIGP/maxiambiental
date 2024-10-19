# frozen_string_literal: true

class Clients::Devise::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create]

  def after_sign_out_path_for(_resource)
    new_client_session_path
  end
end
