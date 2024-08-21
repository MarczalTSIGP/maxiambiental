class Users::Devise::SessionsController < Devise::SessionsController
    prepend_before_action :require_no_authentication

    layout 'layouts/users/devise/session'

    def after_sign_in_path_for(_resource)
        root_path
    end
end