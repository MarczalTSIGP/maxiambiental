class Admin::DashboardController < ApplicationController
  prepend_before_action :authenticate_admin!

  def index; end
end
