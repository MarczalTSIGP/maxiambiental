# frozen_string_literal: true

class Clients::Devise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = Client.from_google(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] =
        t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      name: auth.info.name
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
