class Admin::Dashboard::DashboardController < ApplicationController
  prepend_before_action :authenticate_admin!
  def index
    render 'admin/dashboard/index'
  end
end
