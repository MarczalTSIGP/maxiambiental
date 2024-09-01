class Admin::Devise::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication , only: [:new, :create]

  layout 'layouts/admin/devise/session'

  def after_sign_in_path_for(_resource)
    admin_dashboard_admin_root_path
  end
end
