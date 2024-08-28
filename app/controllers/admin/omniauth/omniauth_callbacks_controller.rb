class Admin::Omniauth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      admin = Admin.from_google(from_google_params)
 
      if admin.present?
        sign_out_all_scopes
        flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect admin, event: :authentication
      else
        flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
        redirect_to new_admin_session_path
      end
     end
 
     def from_google_params
       @from_google_params ||= {
         uid: auth.uid,
         email: auth.info.email
       }
     end
 
     def auth
       @auth ||= request.env['omniauth.auth']
     end
 end